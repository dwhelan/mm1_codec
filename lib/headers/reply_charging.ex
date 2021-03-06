defmodule MMS.ReplyCharging do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.22 X-Mms-Reply-Charging field
  """
  use MMS.Codec
  import MMS.As
  alias MMS.Octet

  @map %{
    128 => :requested,
    129 => :requested_text_only,
    130 => :accepted,
    131 => :accepted_text_only,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_as(Octet, @map)
  end

  def encode(value) when is_atom(value) do
    value
    |> encode_as(Octet, @map)
  end
end
