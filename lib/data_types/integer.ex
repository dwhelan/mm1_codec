defmodule MMS.Integer do
  use MMS.Codec2

  alias MMS.{Short, Long}

  def decode bytes = <<1::1, _::7, _::binary>> do
    bytes |> decode_with(Short)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_with(Long)
  end

  def encode(value) when is_short(value) do
    value |> encode_with(Short)
  end

  def encode(value) when is_integer(value) do
    value |> encode_with(Long)
  end
end
