defmodule WAP.TextString do
  use MM1.BaseCodec

  def decode <<bytes::binary>> do
    handle String.split bytes, <<0>>, parts: 2
  end

  defp handle [text | [rest]] do
    ok text, text <> <<0>>, rest
  end

  defp handle [bytes | []] do
    error2 bytes, :missing_terminator, bytes, <<>>
  end

  def new text do
    ok text, text <> <<0>>
  end
end
