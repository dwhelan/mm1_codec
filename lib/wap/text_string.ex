defmodule WAP.TextString do
  use MM1.Codecs.Base

  def decode <<bytes::binary>> do
    _decode String.split bytes, <<0>>, parts: 2
  end

  defp _decode [text | [rest]] do
    decode_ok text, text <> <<0>>, rest
  end

  defp _decode [text | []] do
    decode_error :missing_terminator, text, text, <<>>
  end

  def new text do
    new_ok text, text <> <<0>>
  end
end
