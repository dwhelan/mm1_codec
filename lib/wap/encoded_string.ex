defmodule WAP.EncodedString do
  use MM1.BaseCodec
  alias MM1.Result

  alias WAP.{ValueLength, CharSet, TextString}

  def decode(<<value, _::binary>> = data) when is_Text(value) do
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
    embed TextString.new text
  end

  defp bytes ~> codec when is_binary(bytes) do
    embed codec.decode bytes
  end

  defp previous ~> codec do
    result = codec.decode previous.rest
    previous_value = if is_tuple(previous.value), do: previous.value, else: {previous.value}
    embed %Result{result | value: Tuple.append(previous_value, result.value), bytes: previous.bytes <> result.bytes}
  end
end
