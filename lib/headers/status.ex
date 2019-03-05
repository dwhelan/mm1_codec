defmodule MMS.Status do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.32 X-Mms-Status field
  """
  use MMS.Codec
  alias MMS.Byte

  @map %{
    128 => :expired,
    129 => :retrieved,
    130 => :rejected,
    131 => :deferred,
    132 => :unrecognized,
    133 => :indeterminate,
    134 => :forwarded,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_as(Byte, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode_as(Byte, @map)
  end
end
