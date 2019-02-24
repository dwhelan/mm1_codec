defmodule MMS.Codec2 do
  import OkError
  import CodecError
  import OkError.Operators

  def decode_ok value, rest do
    ok {value, rest}
  end

  def error data_type, input, details do
    error {data_type, input, details}
  end

  def nest_error({data_type, _, error}) when is_list(error) do
    [data_type | error]
  end

  def nest_error {data_type, _, error} do
    [data_type, error]
  end

  def nest_error reason do
    reason
  end

  defmacro decode_with bytes, codec do
    data_type = data_type( __CALLER__.module)
    quote do
      Kernel.apply(unquote(codec), :decode, [unquote(bytes)])
      ~>> fn details -> error unquote(data_type), unquote(bytes), nest_error(details) end
    end
  end

  defmacro encode_with value, codec do
    data_type = data_type( __CALLER__.module)
    quote do
      Kernel.apply(unquote(codec), :encode, [unquote(value)])
      ~>> fn details -> error unquote(data_type), unquote(value), nest_error(details) end
    end
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
        error {data_type(), <<>>, :no_bytes}
      end

      @deprecate "Use decode_error/2 or encode_error/2"
      defp error input, details do
        error data_type(), input, nest_error(details)
      end

      defp decode_error input, details do
        error data_type(), input, nest_error(details)
      end

      defp encode_error input, details do
        error data_type(), input, nest_error(details)
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

      unquote(input) |> maybe_create_codec_error(data_type())
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
      |> MMS.Codec.maybe_create_codec_error(data_type())
    end
  end

  def maybe_create_codec_error result, data_type do
    case result |> wrap do
      {:error, nil}               -> error data_type, []
      {:error, {reason, history}} -> error data_type, [reason | history]
      {:error, reason}            -> error data_type, [reason]
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
