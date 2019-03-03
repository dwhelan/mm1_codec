defmodule MMS.MessageClass do
  use MMS.Either, [MMS.KnownMessageClass, MMS.Text]
end

defmodule MMS.KnownMessageClass do
  use MMS.Codec2
  import Codec.Map
  alias MMS.Byte

  @map %{
    128 => :personal,
    129 => :advertisement,
    130 => :informational,
    131 => :auto
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(Byte, @map)
  end

  def encode value do
    value |> encode(Byte, @map)
  end
end
