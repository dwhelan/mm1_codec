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

defmodule Codec.Encode do
  def error code, value do
    OkError.error code: code, value: value
  end

  def error code, bytes, value do
    OkError.error code: code, bytes: bytes, value: value
  end

  defmacro __using__ _ do
    quote do
      import DataTypes
      import OkError
      import Codec.Encode
    end
  end
end

defmodule Codec.Decode do
  def ok value, rest do
    OkError.ok {value, rest}
  end

  def error code, bytes do
    OkError.error code: code, bytes: bytes
  end

  def error code, bytes, value do
    OkError.error code: code, bytes: bytes, value: value
  end

  defmacro __using__ _ do
    quote do
      import DataTypes
      import OkError
      import Codec.Decode

      def decode <<>> do
        error :insufficient_bytes, <<>>
      end
    end
  end
end

defmodule Byte.DecodeTest do
  use DecodeTest

  import MMS.Byte.Decode

  test "decode with no bytes" do
    assert decode(<<>>) == error :insufficient_bytes, <<>>
  end

  test "decode with bytes" do
    assert decode(<<0,   "rest">>) == ok 0,   <<"rest">>
    assert decode(<<255, "rest">>) == ok 255, <<"rest">>
  end
end

defmodule Byte.EncodeTest do
  use EncodeTest

  import MMS.Byte.Encode

  test "encode with a byte" do
    assert encode(0)   == ok <<0>>
    assert encode(255) == ok <<255>>
  end

  test "encode with a non-byte" do
    assert encode(256) == error :invalid_byte, 256
  end
end
