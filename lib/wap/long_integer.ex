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

  def decode(<<length, rest::binary>>) when length < 1 or length > 30 do
    decode_error length, :length_must_be_between_1_and_30, <<length>>, rest
  end

  def decode(<<length, rest::binary>> = bytes) when byte_size(rest) < length do
    decode_error length, :insufficient_bytes, bytes, <<>>
  end

  def decode <<length, bytes::binary>> do
    {value_bytes, rest} = String.split_at bytes, length
    decode_ok :binary.decode_unsigned(value_bytes), <<length>> <> value_bytes, rest
  end

  def new(value) when is_long_integer(value) do
    bytes = :binary.encode_unsigned value
    new_ok value, <<byte_size bytes>> <> bytes
  end

  def new value do
    new_error value, :must_be_an_integer_between_1_and_30_bytes_long
  end
end
