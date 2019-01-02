defmodule MMS.ShortLength do
  use MMS.Codec

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    ok value, rest
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  defaults()
end
