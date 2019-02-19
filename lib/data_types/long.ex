defmodule MMS.Long do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Long-integer = Short-length Multi-octet-integer
    The Short-length indicates the length of the Multi-octet-integer

    Multi-octet-integer = 1*30 OCTET
    The content octets shall be an unsigned integer value with the most significant octet
    encoded first (big-endian representation).
    The minimum number of octets must be used to encode the value.
  """
  use MMS.Codec2

  alias MMS.ShortLength

  def decode bytes do
    bytes
    |> ShortLength.decode
    ~> check_length
    ~> to_unsigned
    ~>> fn details -> error bytes, details end
  end

  defp check_length {0, _bytes} do
    error :must_have_at_least_one_data_byte
  end

  defp check_length {length, bytes} do
    ok length, bytes
  end

  defp to_unsigned {length, bytes} do
    bytes |> String.split_at(length) |> decode_long
  end

  defp decode_long {long_bytes, rest} do
    ok :binary.decode_unsigned(long_bytes), rest
  end

  def encode(value) when is_long(value) do
    value |> :binary.encode_unsigned |> ShortLength.prepend_length
  end

  def encode value do
    error :long, value, :out_of_range
  end
end
