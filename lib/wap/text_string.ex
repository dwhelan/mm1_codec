defmodule WAP.TextString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    handle String.split bytes, <<0>>, parts: 2
  end

  defp handle [text | [rest]] do
    decode_ok text, text <> <<0>>, rest
  end

  defp handle [text | []] do
    decode_error :missing_terminator, text, text, <<>>
  end

  def new text do
    new_ok text, text <> <<0>>
  end
end
