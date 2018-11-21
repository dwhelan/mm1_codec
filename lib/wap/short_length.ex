defmodule WAP.ShortLength do
  use MM1.BaseCodec

  def decode <<byte, rest::binary>> do
    value byte, <<byte>>, rest
  end
end
