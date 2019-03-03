defmodule MMS.MessageClass do
  use MMS.Codec2
  import Codec.Map
  alias MMS.{Byte, Text}

  @map %{
    128 => :personal,
    129 => :advertisement,
    130 => :informational,
    131 => :auto
  }

  def decode(text = <<char, _::binary>>) when is_char(char) do
    text |> decode_with(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(Byte, @map)
  end

  def encode(value) when is_binary(value) do
    value |> encode_with(Text)
  end

  def encode(value) when is_atom(value) do
    value |> encode(Byte, @map)
  end
end
