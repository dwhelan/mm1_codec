defmodule MMS.Codec2 do
  import OkError

  def ok value, rest do
    ok {value, rest}
  end

  def error code, input, details do
    error {code, input, details}
  end

  def reason {_, _, reason} do
    reason
  end

  def error_detail_list details do
    details
    |> do_error_detail_list([])
    |> Enum.reverse
  end

  defp do_error_detail_list({code, _, details}, list) when is_tuple(details) do
    details |> do_error_detail_list([code | list])
  end

  defp do_error_detail_list {code, _, details}, list do
    [details, code | list]
  end

  defmacro __using__ (_ \\ []) do
    quote do
      import MMS.DataTypes
      import Monad.Operators
      import OkError
      import OkError.Operators
      import MMS.Codec2
      import CodecError

      def decode <<>> do
        error {error_name(), <<>>, :no_bytes}
      end

      defp error input, details do
        error error_name(), input, details
      end
    end
  end
end

defmodule MMS.Codec do
  import OldOkError
  import OldOkError.Operators
  import CodecError

  defmacro codec_error input \\ nil do
    quote do
      require CodecError

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
      require CodecError

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
      import OldOkError
      import OldOkError.Operators
      import MMS.{DataTypes, Codec}
      import CodecError
      import Codec.String

      def decode(nil),  do: module_error()
      def decode(<<>>), do: module_error()
      def decode(value) when not is_binary(value), do: module_error()
    end
  end

  defmacro __using__(_opts) do
    raise ArgumentError, "'use MMS.Codec' does not accept any options"
  end
end
