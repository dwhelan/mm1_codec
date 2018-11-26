defmodule WAP.ShortInteger do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Short-integer = OCTET

    Integers in range 0-127 shall be encoded as a one octet value with the most
    significant bit set to one (1xxx xxxx) and with the value in the remaining
    least significant bits.
  """

  use MM1.BaseCodec

  def decode(<<value, rest::binary>>) when value >= 128 do
    value value-128, <<value>>, rest
  end

  def decode <<value, rest::binary>> do
    error :most_signficant_bit_must_be_1, value, <<value>>, rest
  end

  def new(value) when is_integer(value) and value >= 0 and value < 128 do
    value value, <<value+128>>
  end

  def new value do
    error :must_be_an_integer_between_0_and_127, value
  end
end
