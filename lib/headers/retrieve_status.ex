defmodule MMS.RetrieveStatus do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.29 X-Mms-Retrieve-Status field

  Reply-charging-value = Requested | Requested text only | Accepted | Accepted text only

  Requested           = <Octet 128>
  Requested text only = <Octet 129>
  Accepted            = <Octet 130>
  Accepted text only  = <Octet 131>
  """

  use MMS.Codec2
  import Codec.Map
  alias MMS.{Byte}

  @map %{
    128 => :ok,
    192 => :transient_failure,
    193 => :transient_message_not_found,
    194 => :transient_network_problem,
    224 => :permanent_failure,
    225 => :permanent_service_denied,
    226 => :permanent_message_not_found,
    227 => :content_unsupported,
  }

  def decode bytes do
    bytes |> decode(Byte, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode(Byte, @map)
  end
end
