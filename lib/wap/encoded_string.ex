defmodule WAP.EncodedString do
  use MM1.BaseCodec

  alias WAP.TextString
  alias WAP.ValueLength

  def decode(<<char, rest::binary>> = data) when char >= 32 do
    return TextString.decode data
  end

  def decode data do
    value_length = ValueLength.decode data
    char_set = WAP.CharSet.decode value_length.rest
    text_string = WAP.TextString.decode char_set.rest
    value %{charset: :csUTF8, text: text_string.value},
      value_length.bytes <> char_set.bytes <> text_string.bytes, text_string.rest
  end

  defp return [text | [rest]] do
    value %{charset: :other, text: "text"}, text <> <<0>>, rest
  end

  defp return [bytes | []] do
    error :insufficient_bytes, bytes
  end
end
