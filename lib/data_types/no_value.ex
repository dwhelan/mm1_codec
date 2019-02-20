defmodule MMS.NoValue do
  use MMS.Codec2

  def decode <<0, rest::binary>> do
    ok :no_value, rest
  end

  def decode bytes = <<value, _::binary>> do
    decode_error bytes, %{out_of_range: value}
  end

  def encode :no_value do
    ok <<0>>
  end
end
