defmodule WAP.TextString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    return String.split bytes, <<0>>, parts: 2
  end

  defp return [text | [rest]] do
    value text, text <> <<0>>, rest
  end

  defp return [bytes | []] do
    error2 :missing_terminator, bytes, bytes, <<>>
  end

  def new text do
    value text, text <> <<0>>
  end
end
