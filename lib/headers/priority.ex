defmodule MMS.Priority do
  @moduledoc """
  Priority-value = Low | Normal | High

  Low    = <Octet 128>
  Normal = <Octet 129>
  High   = <Octet 130>
  """
  use MMS.Codec2
  import Codec.Map
  alias MMS.Byte

  @map %{
    128 => :low,
    129 => :normal,
    130 => :high,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(Byte, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode(Byte, @map)
  end
end
