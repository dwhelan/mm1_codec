defmodule WAP.LongInteger do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Long-integer = Short-length Multi-octet-integer
    The Short-length indicates the length of the Multi-octet-integer

    Multi-octet-integer = 1*30 OCTET
    The content octets shall be an unsigned integer value with the most significant octet
    encoded first (big-endian representation).
    The minimum number of octets must be used to encode the value.
  """

  use MM1.BaseCodec

  def decode(<<length, bytes::binary>>) when length <= 30 do
    decode length, bytes
  end

  def decode <<length, _::binary>> do
    error :length_cannot_be_greater_than_30, length
  end

  defp decode length, bytes do
    <<value::binary-size(length), rest::binary>> = bytes
    value :binary.decode_unsigned(value), <<length, value::binary-size(length)>>, rest
  end

  def new value do
    bytes = :binary.encode_unsigned value
    value value, <<byte_size bytes>> <> :binary.encode_unsigned value
  end
end
