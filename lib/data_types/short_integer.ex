defmodule MMS.ShortInteger do
  @moduledoc """
  8.4.2.1 Basic rules

  Short-integer = OCTET

  Integers in range 0-127 shall be encoded as a one octet value with the most
  significant bit set to one (1xxx xxxx) and with the value in the remaining
  least significant bits.
  """
  use MMS.Codec

  def decode <<1::1, value::7, rest::binary>> do
    ok value, rest
  end

  def decode(bytes = <<value, _::binary>>) do
    error bytes, out_of_range: value
  end

  def encode(value) when value in 0..127 do
    ok <<1::1, value::7>>
  end

  def encode value do
    error value, :out_of_range
  end
end
