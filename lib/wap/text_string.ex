defmodule WAP.TextString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    return String.split bytes, <<0>>, parts: 2
  end

  defp return [text | [rest]] do
    value text, text <> <<0>>, rest
  end

  defp return [bytes | []] do
    error :missing_terminator, <<>>, bytes
  end
end
