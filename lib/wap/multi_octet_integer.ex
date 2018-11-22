defmodule WAP.MultiOctetInteger do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Multi-octet-integer = 1*30 OCTET
    The content octets shall be an unsigned integer value with the most significant octet
    encoded first (big-endian representation).
    The minimum number of octets must be used to encode the value.
  """

  use MM1.BaseCodec

  def decode <<count, value, rest::binary>> do
    value value, <<count, value>>, rest
  end
#  def decode _, 0  do
#    error :length_cannot_be_zero
#  end
#
#  def decode(_, length) when length > 30  do
#    error :length_greater_than_30
#  end
#
#  def decode(bytes, length) when byte_size(bytes) < length do
#    error :insufficent_bytes
#  end
#
#  def decode <<0, 0>>, _ do
#    error :cannot_have_leading_zeros
#  end
#
#  def decode bytes, length do
#    <<value::binary-size(length), rest::binary>> = bytes
#    ok :binary.decode_unsigned(value), rest
#  end
end
