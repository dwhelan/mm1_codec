defmodule MMS.NoValue do
  use MMS.Codec2

  def decode(<<byte, rest::binary>>) when is_no_value_byte(byte) do
    ok no_value(), rest
  end

  def decode bytes = <<value, _::binary>> do
    bytes |> decode_error(%{out_of_range: value})
  end

  def encode(no_value) when is_no_value(no_value) do
    ok <<no_value_byte()>>
  end
end
