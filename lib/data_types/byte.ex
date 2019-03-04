defmodule MMS.Byte do
  use MMS.Codec

  def decode <<byte, rest::binary>> do
    byte |> decode_ok(rest)
  end

  def encode(byte) when is_byte(byte) do
    <<byte>> |> ok
  end

  def encode value do
    value |> encode_error(:out_of_range)
  end
end
