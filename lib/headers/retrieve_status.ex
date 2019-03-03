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

    # Transient failures
    192 => {:transient_failure, :generic},
    193 => {:transient_failure, :message_not_found},
    194 => {:transient_failure, :network_problem},

    # The values 195 through 223 are reserved for future use to indicate other transient failures.

    224 => :permanent_failure,
    225 => {:permanent_failure, :service_denied},
    226 => {:permanent_failure, :message_not_found},
    227 => {:permanent_failure, :content_unsupported},
    228 => {:permanent_failure, 228},
    229 => {:permanent_failure, 229},
    230 => {:permanent_failure, 230},
    231 => {:permanent_failure, 231},
    232 => {:permanent_failure, 232},
    233 => {:permanent_failure, 233},
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

  def decode(<<status, rest::binary>>) when status in 195..223 do
    decode_ok {:transient_failure, status}, rest
  end

  def decode bytes do
    bytes |> decode(Byte, @map)
  end

    def encode({:transient_failure, status}) when status in 195..223 do
    ok <<status>>
  end

  def encode(value) do
    value |> encode(Byte, @map)
  end
end
