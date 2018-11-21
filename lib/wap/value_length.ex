defmodule WAP.ValueLength do
  use MM1.BaseCodec

  @length_quote 31

  def decode(<<length, _::binary>> = bytes) when length <= 30 do
    return WAP.ShortLength.decode bytes
  end

  def decode <<@length_quote, bytes::binary>> do
    result = WAP.Uintvar.decode bytes
    return %Result{result | bytes: <<@length_quote>> <> result.bytes}
  end
end
