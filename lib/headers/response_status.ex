defmodule MMS.ResponseStatus do
  use MMS.Codec2
  import Codec.Map
  alias MMS.{Byte}

  @map %{
    128 => :ok,

    # Obsolete failure
    129 => {:obsolete, :unspecified},
    130 => {:obsolete, :service_denied},
    131 => {:obsolete, :message_format_corrupt},
    132 => {:obsolete, :sending_address_unresolved},
    133 => {:obsolete, :message_not_found},
    134 => {:obsolete, :network_problem},
    135 => {:obsolete, :content_not_accepted},

    136 => :unsupported_message,

    # Transient failures
    192 => {:transient_failure, :generic},
    193 => {:transient_failure, :sending_address_unresolved},
    194 => {:transient_failure, :message_not_found},
    195 => {:transient_failure, :network_problem},

    # Permanent failures
    224 => :permanent_failure,
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
    # An MMS Client MUST react the same to a value in range 234 to 255 as it does to the value 224 (Error-permanent-failure).
    234 => {:permanent_failure, 234},
    235 => {:permanent_failure, 235},
    236 => {:permanent_failure, 236},
    237 => {:permanent_failure, 237},
    238 => {:permanent_failure, 238},
    239 => {:permanent_failure, 239},
    240 => {:permanent_failure, 240},
    241 => {:permanent_failure, 241},
    242 => {:permanent_failure, 242},
    243 => {:permanent_failure, 243},
    244 => {:permanent_failure, 244},
    245 => {:permanent_failure, 245},
    246 => {:permanent_failure, 246},
    247 => {:permanent_failure, 247},
    248 => {:permanent_failure, 248},
    249 => {:permanent_failure, 249},
    250 => {:permanent_failure, 250},
    251 => {:permanent_failure, 251},
    252 => {:permanent_failure, 252},
    253 => {:permanent_failure, 253},
    254 => {:permanent_failure, 254},
    255 => {:permanent_failure, 255},
  }

  # The values 196 through 223 are reserved for future use to indicate other transient failures.
  def decode(<<status, rest::binary>>) when status in 196..223 do
    decode_ok {:transient_failure, status}, rest
  end

  def decode bytes do
    bytes |> decode(Byte, @map)
  end

  def encode({:transient_failure, status}) when status in 196..223 do
    ok <<status>>
  end

  def encode(value) do
    value |> encode(Byte, @map)
  end
end
