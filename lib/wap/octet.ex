defmodule WAP.Octet do
  use MM1.BaseCodec

  def decode <<octet, _::binary>> = bytes do
    value octet, 1, bytes
  end

  def encode value do
    <<value>>
  end
end
