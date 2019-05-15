defmodule MMS.MultiOctetInteger do
  @moduledoc """
  8.4.2.1 Basic rules

  Multi-octet-integer = 1*30 OCTET
  The content octets shall be an unsigned integer value with the most significant octet
  encoded first (big-endian representation).
  The minimum number of octets must be used to encode the value.
  """
  import MMS.As

  use MMS.Codec

  alias MMS.ShortLength

  def decode bytes do
    bytes
    |> String.split_at(30)
    ~> fn {value_bytes, rest} ->
         value_bytes
         |> :binary.decode_unsigned
         |> ok(rest)
       end
  end

  def encode(value) when is_long(value) do
    value
    |> :binary.encode_unsigned
    |> ok
  end

  def encode value do
    error value, :out_of_range
  end
end
