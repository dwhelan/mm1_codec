defmodule WAP.TextString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    return String.split(bytes, <<0>>, parts: 2)
  end

  defp return [ _ | [] ]do
    error :insufficient_bytes
  end

  defp return [text | [rest] ]do
    value text, text <> <<0>>, rest
  end

#  def encode result do
#    result.bytes
#  end
end
