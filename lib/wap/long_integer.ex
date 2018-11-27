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
    error2 length, :length_must_be_between_1_and_30, <<length>>, rest
  end

  def decode(<<length, rest::binary>> = bytes) when byte_size(rest) < length do
    error2 bytes, :insufficient_bytes, bytes
  end

  def decode <<length, bytes::binary>> do
    <<value::binary-size(length), rest::binary>> = bytes
    ok :binary.decode_unsigned(value), <<length, value::binary-size(length)>>, rest
  end

  def new(value) when is_integer(value) and value >= 0 do
    _new value, :binary.encode_unsigned value
  end

  def new value do
    error2 value, :must_be_an_integer_greater_than_or_equal_to_0
                end

  def _new(value, bytes) when byte_size(bytes) > 30 do
    error2 value, :must_fit_within_30_bytes
                                                    end

  def _new value, bytes do
    ok value, <<byte_size bytes>> <> bytes
  end
end
