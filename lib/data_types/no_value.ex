defmodule MMS.NoValue do
  use MMS.Codec2

  def decode <<0, rest::binary>> do
    ok :no_value, rest
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :must_be_zero
  end

  def encode :no_value do
    ok <<0>>
  end
end
