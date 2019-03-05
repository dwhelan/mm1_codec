defmodule MMS.ResponseStatus do
  use MMS.Codec
  alias MMS.{Byte}

  @map %{
    128 => :ok,

    # Obsolete failure
    129 => {:permanent_failure, :obsolete_unspecified},
    130 => {:permanent_failure, :obsolete_service_denied},
    131 => {:permanent_failure, :obsolete_message_format_corrupt},
    132 => {:permanent_failure, :obsolete_sending_address_unresolved},
    133 => {:transient_failure, :obsolete_message_not_found},
    134 => {:transient_failure, :obsolete_network_problem},
    135 => {:permanent_failure, :obsolete_content_not_accepted},

    136 => {:permanent_failure, :unsupported_message},

    # Transient failures
    192 => {:transient_failure, :unspecified},
    193 => {:transient_failure, :sending_address_unresolved},
    194 => {:transient_failure, :message_not_found},
    195 => {:transient_failure, :network_problem},

    # The values 196 through 223 are reserved for future use to indicate other transient failures.

    # Permanent failures
    224 => {:permanent_failure, :unspecified},
    225 => {:permanent_failure, :service_denied},
    226 => {:permanent_failure, :message_format_corrupt},
    227 => {:permanent_failure, :sending_address_unresolved},
    228 => {:permanent_failure, :message_not_found},
    229 => {:permanent_failure, :content_not_accepted},
    230 => {:permanent_failure, :reply_charging_limitations_not_met},
    231 => {:permanent_failure, :reply_charging_request_not_accepted},
    232 => {:permanent_failure, :reply_charging_forwarding_denied},
    233 => {:permanent_failure, :reply_charging_not_supported},

    # The values 234 through 255 are reserved for future use to indicate other permanent failures.
  }

  def decode(<<status, rest::binary>>) when status in 196..223 do
    decode_ok {:transient_failure, status}, rest
  end

  def decode(<<status, rest::binary>>) when status in 234..255 do
    decode_ok {:permanent_failure, status}, rest
  end

  def decode bytes do
    bytes |> decode_as(Byte, @map)
  end

  def encode({:transient_failure, status}) when status in 196..223 do
    ok <<status>>
  end

  def encode({:permanent_failure, status}) when status in 234..255 do
    ok <<status>>
  end

  def encode(value) do
    value |> encode_as(Byte, @map)
  end
end
