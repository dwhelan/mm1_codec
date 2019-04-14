defmodule MMS.NoValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  The following rules are used in encoding parameter values.
  No-value = <Octet 0>
  """
  use MMS.Codec

  def decode(<<byte, rest::binary>>) when is_no_value_byte(byte) do
    ok no_value(), rest
  end

  def decode bytes = <<value, _::binary>> do
    error bytes, out_of_range: value
  end

  def encode(no_value) when is_no_value(no_value) do
    ok <<no_value_byte()>>
  end

  def encode value do
    error value, :out_of_range
  end
end
