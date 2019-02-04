defmodule MMS.Byte do
  use MMS.Codec2, error: :invalid_byte

  def decode <<byte, rest::binary>> do
    ok byte, rest
  end

  def encode(byte) when is_byte(byte) do
    ok <<byte>>
  end

  def encode value do
    error :invalid_byte, value, :out_of_range
  end
end
