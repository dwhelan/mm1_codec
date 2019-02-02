defmodule MMS.Byte do
  use Codec2

  def decode <<byte, rest::binary>> do
    ok byte, rest
  end

  def encode(byte) when is_byte(byte) do
    ok <<byte>>
  end

  def encode value do
    error code: :invalid_byte, value: value
  end
end
