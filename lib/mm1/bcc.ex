defmodule MM1.Bcc do
  use MM1.BaseCodec

  @octet MM1.Headers.octet __MODULE__

  def decode <<@octet, value, _::binary>> = bytes do
    value value, 2, bytes
  end

  def encode value do
    <<@octet, value>>
  end
end
