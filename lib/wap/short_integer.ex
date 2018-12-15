defmodule MMS.ShortInteger do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Short-integer = OCTET

    Integers in range 0-127 shall be encoded as a one octet value with the most
    significant bit set to one (1xxx xxxx) and with the value in the remaining
    least significant bits.
  """
  import MM1.OkError
  import WAP.Guards

  def decode(<<1::1, value::7, rest::binary>>) do
    ok {value, rest}
  end

  def decode bytes do
    error :most_signficant_bit_must_be_1
  end

  def encode(value) when is_short_integer(value) do
    ok <<value+128>>
  end

  def encode value do
    error :must_be_an_integer_between_0_and_127
  end
end
