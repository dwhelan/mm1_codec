defmodule WAP.TextString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    handle String.split bytes, <<0>>, parts: 2
  end

  defp handle [text | [rest]] do
    ok text, text <> <<0>>, rest
  end

  defp handle [text | []] do
    decode_error text, :missing_terminator, text, <<>>
  end

  def new text do
    ok text, text <> <<0>>
  end
end
