defmodule WAP.EncodedString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    return String.split bytes, <<0>>, parts: 2
  end

  defp return [text | [rest]] do
    value %{charset: {:other, 1}, text: "text"}, text <> <<0>>, rest
  end

  defp return [bytes | []] do
    error :insufficient_bytes, bytes
  end
end
