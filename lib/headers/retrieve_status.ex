defmodule MMS.RetrieveStatus do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.29 X-Mms-Retrieve-Status field

  Reply-charging-value = Requested | Requested text only | Accepted | Accepted text only

  Requested           = <Octet 128>
  Requested text only = <Octet 129>
  Accepted            = <Octet 130>
  Accepted text only  = <Octet 131>
  """

  use MMS.Codec
  alias MMS.{Byte}

  @map %{
    128 => :ok,

    # Transient failures
    192 => {:transient_failure, :unspecified},
    193 => {:transient_failure, :message_not_found},
    194 => {:transient_failure, :network_problem},

    # The values 195 through 223 are reserved for future use to indicate other transient failures.

    # Permanent failures
    224 => {:permanent_failure, :unspecified},
    225 => {:permanent_failure, :service_denied},
    226 => {:permanent_failure, :message_not_found},
    227 => {:permanent_failure, :content_unsupported},

    # The values 228 through 255 are reserved for future use to indicate other permanent failures.
  }

  def decode(<<status, rest::binary>>) when status in 195..223 do
    decode_ok {:transient_failure, status}, rest
  end

  def decode(<<status, rest::binary>>) when status in 228..255 do
    decode_ok {:permanent_failure, status}, rest
  end

  def decode bytes do
    bytes |> decode_as(Byte, @map)
  end

    def encode({:transient_failure, status}) when status in 195..223 do
    ok <<status>>
  end

  def encode({:permanent_failure, status}) when status in 228..255 do
    ok <<status>>
  end

  def encode(value) do
    value |> encode_with(Byte, @map)
  end
end
