defmodule WAP.ShortLength do
  use MM1.BaseCodec

  def decode(<<length, rest::binary>>) when length <= 30 do
    value length, <<length>>, rest
  end
end
