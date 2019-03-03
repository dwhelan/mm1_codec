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
    192 => :transient_failure,
    193 => {:transient_failure, :message_not_found},
    194 => {:transient_failure, :network_problem},

    # The values 195 through 223 are reserved for future use to indicate other transient failures.
    195 => {:transient_failure, 195},
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

    224 => :permanent_failure,
    225 => {:permanent_failure, :service_denied},
    226 => {:permanent_failure, :message_not_found},
    227 => :content_unsupported,
  }

  def decode bytes do
    bytes |> decode(Byte, @map)
  end

  def encode(value) do
    value |> encode(Byte, @map)
  end
end
