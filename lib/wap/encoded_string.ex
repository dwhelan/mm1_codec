defmodule WAP.EncodedString do
  use MM1.BaseCodec

  alias WAP.TextString
  alias WAP.ValueLength

  def decode(<<char, _::binary>> = data) when char >= 32 do
    return TextString.decode data
  end

  def decode data do
    data ~> ValueLength ~> WAP.CharSet ~> WAP.TextString
  end

  defp bytes ~> codec when is_binary(bytes) do
    result = codec.decode bytes
    return %Result{result | value: {result.value}}
  end

  defp previous ~> codec do
    result = codec.decode previous.rest
    return %Result{result | value: Tuple.append(previous.value, result.value), bytes: previous.bytes <> result.bytes}
  end

  defp return [text | [rest]] do
    value %{charset: :other, text: "text"}, text <> <<0>>, rest
  end

  defp return [bytes | []] do
    error :insufficient_bytes, bytes
  end
end
