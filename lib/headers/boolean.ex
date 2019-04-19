defmodule MMS.Boolean do
  @moduledoc """
  Specification: OMA-WAP-MMS-ENC-V1_1-20040715-A

  This Codec decodes and encodes boolean values to support the following MMS heades:

  7.2.6 X-Mms-Delivery-Report field
    Delivery-report-value = Yes | No
    Yes = <Octet 128>
    No  = <Octet 129>

  7.2.20 X-Mms-Read-Report field
    Read-report-value = Yes | No
    Yes = <Octet 128>
    No  = <Octet 129>

  7.2.26 X-Mms-Report-Allowed field
    Report-allowed-value = Yes | No
    Yes = <Octet 128>
    No  = <Octet 129>
  """
  use MMS.Codec
  import MMS.As
  alias MMS.Octet

  @map %{
    128 => true,
    129 => false,
  }

  def decode bytes do
    bytes |> decode_as(Octet, @map)
  end

  def encode value do
    value |> encode_as(Octet, @map)
  end
end
