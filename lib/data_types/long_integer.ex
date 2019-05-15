defmodule MMS.LongInteger do
  @moduledoc """
  8.4.2.1 Basic rules

  Long-integer = Short-length Multi-octet-integer

  The Short-length indicates the length of the Multi-octet-integer

  Multi-octet-integer = 1*30 OCTET
  The content octets shall be an unsigned integer value with the most significant octet
  encoded first (big-endian representation).
  The minimum number of octets must be used to encode the value.
  """
  use MMS.Codec
  import MMS.Length

  alias MMS.{ShortLength, MultiOctetInteger}

  def decode bytes do
    bytes
    |> decode_with_length(ShortLength, MultiOctetInteger)
  end

  def encode(value) do
    value
    |> encode_with_length(ShortLength, MultiOctetInteger)
  end
end
