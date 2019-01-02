defmodule MMS.Byte do
  use MMS.Codec

  def decode <<byte, rest::binary>> do
    ok byte, rest
  end

  def encode(value) when is_byte(value) do
    ok <<value>>
  end

  defaults()
end
