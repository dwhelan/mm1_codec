defmodule MMS.Codec do
  import OkError
  import OkError.{Module, Operators}

  defmacro codec_error input \\ nil do
    quote do
      require OkError.Module

      unquote(input) |> maybe_create_codec_error(error_name())
    end
  end

  defmacro input <~> fun do
    quote do
      case unquote(input) |> wrap do
        {:ok, {value, rest}} -> value |> unquote(fun) ~> ok(rest) # for decode
        {:ok, value}         -> value |> unquote(fun)             # for encode
        error                -> error
      end ~>> module_error()
    end
  end

  defmacro decoded input, fun do
    pipe_decoded_value input, fun
  end

  defmacro input <|> fun do
    pipe_decoded_value input, fun
  end

  defp pipe_decoded_value input, fun do
    quote do
      require OkError.Module

      unquote(input)
      ~> fn {value, rest} -> value |> unquote(fun) ~> ok(rest) end.()
      |> MMS.Codec.maybe_create_codec_error(error_name())
    end
  end

  def maybe_create_codec_error result, error_name do
    case result |> wrap do
      {:error, nil}               -> error error_name, []
      {:error, {reason, history}} -> error error_name, [reason | history]
      {:error, reason}            -> error error_name, [reason]
      ok                          -> ok
    end
  end

  defmacro defaults do
    quote do
      def decode(_), do: module_error()
      def encode(_), do: module_error()
    end
  end

  defmacro __using__([]) do
    quote do
      import OkError
      import OkError.{String, Operators}
      import MMS.{DataTypes, Codec}

      def decode(nil),  do: module_error()
      def decode(<<>>), do: module_error()
      def decode(value) when not is_binary(value), do: module_error()
    end
  end

  defmacro __using__(_opts) do
    raise ArgumentError, "'use MMS.Codec' does not accept any options"
  end
end
