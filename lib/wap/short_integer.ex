defmodule WAP.ShortInteger do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Short-integer = OCTET

    Integers in range 0-127 shall be encoded as a one octet value with the most
    significant bit set to one (1xxx xxxx) and with the value in the remaining
    least significant bits.
  """

  use MM1.Codecs.Base

  def decode(<<1::1, value::7, rest::binary>>) do
    decode_ok value, <<1::1, value::7>>, rest
  end

  def decode <<value, rest::binary>> do
    decode_error :most_signficant_bit_must_be_1, <<value>>, <<value>>, rest
  end

  def new(value) when is_short_integer(value) do
    new_ok value, <<1::1, value::7>>
  end

  def new value do
    new_error :must_be_an_integer_between_0_and_127, value
  end
end

defmodule WAP2.ShortInteger do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Short-integer = OCTET

    Integers in range 0-127 shall be encoded as a one octet value with the most
    significant bit set to one (1xxx xxxx) and with the value in the remaining
    least significant bits.
  """
  import WAP.Guards

  def decode(<<1::1, value::7, rest::binary>>) do
    ok value, rest
  end

  def decode bytes do
    error :most_signficant_bit_must_be_1, bytes
  end

  def encode(value) when is_short_integer(value) do
    ok <<value+128>>, value
  end

  def encode value do
    error :must_be_an_integer_between_0_and_127, value
  end
end
