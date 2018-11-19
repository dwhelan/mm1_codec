defmodule WAP.TextString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    IO.inspect [text | rest] = String.split(bytes, <<0>>, parts: 2)
    value text, text <> <<0>>, hd(rest)
  end

#  def encode result do
#    result.bytes
#  end
end
