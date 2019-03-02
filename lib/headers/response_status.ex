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
    192 => :transient_failure,
    193 => {:transient_failure, :sending_address_unresolved},
    194 => {:transient_failure, :message_not_found},
    195 => {:transient_failure, :network_problem},

    # The values 196 through 223 are reserved for future use to indicate other transient failures.
    196 => {:transient_failure, 196},
    197 => {:transient_failure, 197},
    198 => {:transient_failure, 198},
    199 => {:transient_failure, 199},
    200 => {:transient_failure, 200},
    201 => {:transient_failure, 201},
    202 => {:transient_failure, 202},
    203 => {:transient_failure, 203},
    204 => {:transient_failure, 204},
    205 => {:transient_failure, 205},
    206 => {:transient_failure, 206},
    207 => {:transient_failure, 207},
    208 => {:transient_failure, 208},
    209 => {:transient_failure, 209},
    210 => {:transient_failure, 210},
    211 => {:transient_failure, 211},
    212 => {:transient_failure, 212},
    213 => {:transient_failure, 213},
    214 => {:transient_failure, 214},
    215 => {:transient_failure, 215},
    216 => {:transient_failure, 216},
    217 => {:transient_failure, 217},
    218 => {:transient_failure, 218},
    219 => {:transient_failure, 219},
    220 => {:transient_failure, 220},
    221 => {:transient_failure, 221},
    222 => {:transient_failure, 222},
    223 => {:transient_failure, 223},

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

  def decode bytes do
    bytes |> decode(Byte, @map)
  end

  def encode(value) do
    value |> encode(Byte, @map)
  end
end
