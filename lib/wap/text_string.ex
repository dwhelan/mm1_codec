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

defmodule WAP2.TextString do
  import MM1.OkError

  def decode <<bytes::binary>> do
    bytes |> String.split(<<0>>, parts: 2) |> decode
  end

  def decode [text | [rest]] do
    ok {text, rest}
  end

  def decode [text | []] do
    error :missing_terminator
  end

  def encode text do
    ok text <> <<0>>
  end
end
