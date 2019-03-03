defmodule MMS.ReplyCharging do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.22 X-Mms-Reply-Charging field

  Reply-charging-value = Requested | Requested text only | Accepted | Accepted text only

  Requested           = <Octet 128>
  Requested text only = <Octet 129>
  Accepted            = <Octet 130>
  Accepted text only  = <Octet 131>
  """
  use MMS.Codec2
  import Codec.Map
  alias MMS.Byte

  @map %{
    128 => :requested,
    129 => :requested_text_only,
    130 => :accepted,
    131 => :accepted_text_only,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(Byte, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode(Byte, @map)
  end
end
