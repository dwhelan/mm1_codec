defmodule MM1.Bcc do
  use MM1.BaseCodec
  alias WAP.TextString

  @header MM1.Headers.byte __MODULE__

  def decode <<@header, bytes::binary>> do
    result = TextString.decode bytes
    return %Result{result | bytes: <<@header>> <> result.bytes}
  end
end
