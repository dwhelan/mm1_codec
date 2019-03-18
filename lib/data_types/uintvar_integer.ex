defmodule MMS.UintvarInteger do
  @moduledoc """
  8.1.2 Variable Length Unsigned Integers

  Many fields in the data unit formats are of variable length.
  Typically, there will be an associated field that specifies the size of the variable length field.
  In order to keep the data unit formats as small as possible,
  a variable length unsigned integer encoding is used to specify lengths.
  The larger the unsigned integer, the larger the size of its encoding.
  Each octet of the variable length unsigned integer
  is comprised of a single Continue bit and 7 bits of payload ...

  To encode a large unsigned integer, split it into 7-bit fragments and place them in the payloads of multiple octets.
  The most significant bits are placed in the first octets with the least significant bits ending up in the last octet.
  All octets MUST set the Continue bit to 1 except the last octet, which MUST set the Continue bit to 0.

  The unsigned integer MUST be encoded in the smallest encoding possible.
  In other words, the encoded value MUST NOT start with an octet with the value 0x80.

  8.4.2.1 Basic rules

  Uintvar-integer = 1*5 OCTET

  The encoding is the same as the one defined for uintvar in Section 8.1.2.
  """
  use MMS.Codec, error: :uintvar_integer

  use Bitwise

  def decode bytes = <<128, _::binary>> do
    bytes
    |> decode_error(:first_byte_cannot_be_128)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> do_decode([])
    ~>> & decode_error bytes, &1
  end

  defp do_decode <<1::1, value::7, rest::binary>>, values do
    rest
    |> do_decode([value | values])
  end

  defp do_decode <<last, rest::binary>>, values do
    [last | values]
    |> sum
    |> ensure_uint32(rest)
  end

  defp sum values do
    values
    |> Enum.reverse
    |> Enum.reduce(& &1 + (&2 <<< 7))
  end

  defp ensure_uint32(value, rest) when is_uint32(value) do
    value
    |> decode_ok(rest)
  end

  defp ensure_uint32(value, _rest) do
    error %{out_of_range: value}
  end

  def encode(uint32) when is_uint32(uint32) do
    uint32
    |> do_encode([]) |> ok
  end

  def encode(value) when is_integer(value) do
    value
    |> encode_error(:out_of_range)
  end

  defp do_encode value, [] do
    value >>> 7
    |> do_encode([<<0::1, value::7>>])
  end

  defp do_encode 0, byte_list do
    byte_list
    |> Enum.join
  end

  defp do_encode value, byte_list do
    value >>> 7
    |> do_encode([<<1::1, value::7>> | byte_list])
  end
end
