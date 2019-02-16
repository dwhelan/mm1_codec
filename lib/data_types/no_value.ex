defmodule MMS.NoValue do
  use MMS.Codec2

  def decode(<<byte, rest::binary>>) when is_no_value_byte(byte) do
    ok no_value(), rest
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :must_be_zero
  end

  def encode(value) when is_no_value(value) do
    ok <<no_value_byte()>>
  end
end
