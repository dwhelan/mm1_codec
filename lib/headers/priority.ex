defmodule MMS.Priority do
  @moduledoc """
  Priority-value = Low | Normal | High

  Low    = <Octet 128>
  Normal = <Octet 129>
  High   = <Octet 130>
  """
  use MMS.Codec
  import MMS.As
  alias MMS.Octet

  @map %{
    128 => :low,
    129 => :normal,
    130 => :high,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_as(Octet, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode_as(Octet, @map)
  end
end
