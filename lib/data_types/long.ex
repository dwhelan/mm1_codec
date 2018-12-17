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

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<length, _::binary>>) when length < 1 or length > 30 do
    error :length_must_be_between_1_and_30
  end

  def decode(<<length, rest::binary>>) when byte_size(rest) < length do
    error :insufficient_bytes
  end

  def decode <<length, bytes::binary>> do
    {value_bytes, rest} = String.split_at bytes, length
    ok :binary.decode_unsigned(value_bytes), rest
  end

  def encode(value) when is_long_integer(value) do
    bytes = :binary.encode_unsigned(value)
    ok <<byte_size(bytes)>> <> bytes
  end

  def encode _ do
    error :must_be_an_integer_between_1_and_30_bytes_long
  end
end

