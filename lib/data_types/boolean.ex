defmodule MMS.Boolean do
  use MMS.Codec
  import Codec.Map
  alias MMS.Byte

  @map %{
    128 => true,
    129 => false,
  }

  def decode bytes do
    bytes |> decode(Byte, @map)
  end

  def encode value do
    value |> encode(Byte, @map)
  end
end
