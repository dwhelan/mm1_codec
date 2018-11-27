defmodule WAP.TextString do
  use MM1.BaseCodec
  import MM1.Result

  def decode <<bytes::binary>> do
    return String.split bytes, <<0>>, parts: 2
  end

  defp return [text | [rest]] do
    ok text, text <> <<0>>, rest
  end

  defp return [bytes | []] do
    error2 bytes, :missing_terminator, bytes, <<>>
  end

  def new text do
    ok text, text <> <<0>>
  end
end
