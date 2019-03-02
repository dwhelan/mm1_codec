defmodule MMS.ResponseStatus do
  use MMS.Codec2
  import Codec.Map
  alias MMS.{Byte}

  @map %{
    128 => :ok,
    129 => :unspecified,
    130 => :service_denied,
    131 => :message_format_corrupt,
    132 => :sending_address_unresolved,
    133 => :message_not_found,
    134 => :network_problem,
    135 => :content_not_accepted,
    136 => :unsupported_message,
    192 => :transient_failure,
    193 => :transient_sending_address_unresolved,
    194 => :transient_message_not_found,
    195 => :transient_network_problem,
    196 => :transient_failure_196,
    197 => :transient_failure_197,
    198 => :transient_failure_198,
    199 => :transient_failure_199,
    200 => :transient_failure_200,
    201 => :transient_failure_201,
    202 => :transient_failure_202,
    203 => :transient_failure_203,
    204 => :transient_failure_204,
    205 => :transient_failure_205,
    206 => :transient_failure_206,
    207 => :transient_failure_207,
    208 => :transient_failure_208,
    209 => :transient_failure_209,
    210 => :transient_failure_210,
    211 => :transient_failure_211,
    212 => :transient_failure_212,
    213 => :transient_failure_213,
    214 => :transient_failure_214,
    215 => :transient_failure_215,
    216 => :transient_failure_216,
    217 => :transient_failure_217,
    218 => :transient_failure_218,
    219 => :transient_failure_219,
    220 => :transient_failure_220,
    221 => :transient_failure_221,
    222 => :transient_failure_222,
    223 => :transient_failure_223,
    224 => :permanent_failure,
    225 => :permanent_service_denied,
    226 => :permanent_message_format_corrupt,
    227 => :permanent_sending_address_unresolved,
    228 => :permanent_message_not_found,
    229 => :permanent_content_not_accepted,
    230 => :permanent_reply_charging_limitations_not_met,
    231 => :permanent_reply_charging_request_not_accepted,
    232 => :permanent_reply_charging_forwarding_denied,
    233 => :permanent_reply_charging_not_supported,
  }

  def decode bytes do
    bytes |> decode(Byte, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode(Byte, @map)
  end
end
