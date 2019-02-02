defmodule DataTypes do
  defp is_integer? value, min, max do
    quote do
      is_integer(unquote value) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end

  defmacro is_byte value do
    is_integer? value, 0, 255
  end

  defmacro is_short_length(value) do
    is_integer? value, 0, 30
  end

  def max_long do
    # 30 0xffs
    0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  end

  def max_long_bytes do
    <<30, max_long()::240>>
  end

  defmacro is_long value do
    is_integer? value, 0, max_long()
  end
end

defmodule Codec do
  import OkError

  defmacro __using__ _ do
    quote do
      import DataTypes
      import OkError
      import Monad.Operators
      import OkError.Operators
      import Codec
    end
  end
end

defmodule Codec.Encode do
  import OkError

  def error code, value do
    error code: code, value: value
  end

  defmacro __using__ _ do
    quote do
      use Codec
      import Codec.Encode
    end
  end
end

defmodule Codec.Decode do
  import OkError

  def ok value, rest do
    ok {value, rest}
  end

  def error code, bytes do
    error code: code, bytes: bytes
  end

  def error code, bytes, value do
    error code: code, bytes: bytes, value: value
  end

  defmacro __using__ _ do
    quote do
      use Codec
      import Codec.Decode

      def decode <<>> do
        error :insufficient_bytes, <<>>
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
