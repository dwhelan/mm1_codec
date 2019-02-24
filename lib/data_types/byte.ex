defmodule MMS.Byte do
  use MMS.Codec2

  def decode <<byte, rest::binary>> do
    byte |> decode_ok(rest)
  end

  def encode(byte) when is_byte(byte) do
    ok <<byte>>
  end

  def encode value do
    value |> encode_error(:out_of_range)
  end
end
