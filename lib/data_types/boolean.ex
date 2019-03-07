defmodule MMS.Boolean do
  use MMS.Codec
  alias MMS.Byte

  [
    { 128, true},
    { 129, false}
  ]
  @map %{
    128 => true,
    129 => false,
  }

  def decode bytes do
    bytes |> decode_as(Byte, @map)
  end

  def encode value do
    value |> encode_as(Byte, @map)
  end
end
