defmodule MMS.NoValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  The following rules are used in encoding parameter values.
  No-value = <Octet 0>
  """
  use MMS.Codec

  def decode(<<byte, rest::binary>>) when is_no_value_byte(byte) do
    no_value()
    |> ok(rest)
  end

  def decode bytes = <<value, _::binary>> do
    bytes
    |> decode_error(%{out_of_range: value})
  end

  def encode(no_value) when is_no_value(no_value) do
    <<no_value_byte()>>
    |> ok
  end
end
