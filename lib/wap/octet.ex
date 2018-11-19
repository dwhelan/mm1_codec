defmodule WAP.Octet do
  use MM1.BaseCodec

  def decode <<octet, rest::binary>> do
    value octet, <<octet>>, rest
  end

  def encode result do
    result.bytes
  end
end
