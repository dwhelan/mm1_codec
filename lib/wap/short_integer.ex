defmodule WAP.ShortInteger do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Short-integer = OCTET

    Integers in range 0-127 shall be encoded as a one octet value with the most
    significant bit set to one (1xxx xxxx) and with the value in the remaining
    least significant bits.
  """

  use MM1.BaseCodec

  def decode <<1::1, value::7, rest::binary>> do
    value value, <<1::1, value::7>>, rest
  end
end
