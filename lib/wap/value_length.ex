defmodule WAP.ValueLength do
  use MM1.BaseCodec

  def decode(<<length, rest::binary>> = bytes) when length <= 30 do
    return WAP.ShortLength.decode bytes
  end

  def decode <<31, value, rest::binary>> = bytes do
    value value, <<31, value>>, rest
  end
end
