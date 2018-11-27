defmodule WAP.EncodedString do
  use MM1.BaseCodec

  alias WAP.{ValueLength, CharSet, TextString}

  defmacro is_TextString char do
    char == 0 or char >= 32
  end

  def decode(<<char, _::binary>> = data) when char == 0 or char >= 32 do
    data ~> TextString
  end

  def decode data do
    data ~> ValueLength ~> CharSet ~> TextString
  end

  def new {length, char_set, text} = encoded_string do
    bytes = ValueLength.new(length).bytes() <> CharSet.new(char_set).bytes() <> TextString.new(text).bytes
    ok encoded_string, bytes
  end

  def new text do
    return TextString.new text
  end

  defp bytes ~> codec when is_binary(bytes) do
    return codec.decode bytes
  end

  defp previous ~> codec do
    result = codec.decode previous.rest
    previous_value = if is_tuple(previous.value), do: previous.value, else: {previous.value}
    return %Result{result | value: Tuple.append(previous_value, result.value), bytes: previous.bytes <> result.bytes}
  end

end
