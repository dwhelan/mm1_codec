defmodule MM1.Bcc do
  use MM1.BaseCodec

  def decode <<129, value, _::binary>> = bytes do
    value value, 2, bytes
  end

  def encode value do
    <<129, value>>
  end
end
