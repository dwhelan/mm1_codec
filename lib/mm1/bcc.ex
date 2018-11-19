defmodule MM1.Bcc do
  use MM1.BaseCodec

  @header MM1.Headers.byte __MODULE__

  def decode <<@header, bcc, rest::binary>> do
    value bcc, <<@header, bcc>>, rest
  end

  def encode result do
    result.bytes
  end
end
