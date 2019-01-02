defmodule MMS.NoValue do
  use MMS.Codec

  def decode <<0, rest::binary>> do
    ok :no_value, rest
  end

  def encode :no_value do
    ok <<0>>
  end

  defaults()
end
