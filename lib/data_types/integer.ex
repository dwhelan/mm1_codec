defmodule MMS.Integer do
  use MMS.Codec2

  alias MMS.{ShortInteger, Long}

  def decode(bytes = <<byte, _::binary>>) when is_short_integer_byte(byte) do
    bytes |> decode_with(ShortInteger)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_with(Long)
  end

  def encode(value) when is_short_integer(value) do
    value |> encode_with(ShortInteger)
  end

  def encode(value) when is_integer(value) do
    value |> encode_with(Long)
  end
end
