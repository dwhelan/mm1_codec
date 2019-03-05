defmodule MMS.Boolean do
  use MMS.Codec
  alias MMS.Byte

  @map %{
    128 => true,
    129 => false,
  }

  def decode bytes do
    bytes |> decode_with(Byte, @map)
  end

  def encode value do
    value |> encode_with(Byte, @map)
  end
end
