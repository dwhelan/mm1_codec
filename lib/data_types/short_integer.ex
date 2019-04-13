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
    value
    |> ok(rest)
  end

  def decode(bytes = <<value, _::binary>>) do
    bytes
    |> error(out_of_range: value)
  end

  def encode(value) when is_short_integer(value) do
    <<1::1, value::7>>
    |> ok
  end

  def encode value do
    value
    |> error(:out_of_range)
  end
end
