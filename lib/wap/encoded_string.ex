defmodule WAP.EncodedString do
  use MM1.Codecs.Base
  alias MM1.Result

  alias WAP.{ValueLength, CharSet, TextString}

  def decode(<<value, _::binary>> = data) when is_text(value) do
    data ~> TextString
  end

  def decode data do
    data ~> ValueLength ~> CharSet ~> TextString
  end

  def new {length, char_set, text} = encoded_string do
    bytes = ValueLength.new(length).bytes() <> CharSet.new(char_set).bytes() <> TextString.new(text).bytes
    new_ok encoded_string, bytes
  end

  def new text do
    set_module TextString.new text
  end

  defp bytes ~> codec when is_binary(bytes) do
    set_module codec.decode bytes
  end

  defp previous ~> codec do
    result = codec.decode previous.rest
    previous_value = if is_tuple(previous.value), do: previous.value, else: {previous.value}
    set_module %Result{result | value: Tuple.append(previous_value, result.value), bytes: previous.bytes <> result.bytes}
  end
end

defmodule WAP2.EncodedString do
  import MM1.OkError
  import WAP.Guards

  alias WAP2.{ValueLength, CharSet, TextString}

  def decode(<<byte, _::binary>> = bytes) when is_text(byte) do
    bytes |> TextString.decode
  end

  def decode bytes do
    with {:ok, {length,  charset_bytes}} <- ValueLength.decode(bytes),
         {:ok, {charset, text_bytes   }} <- CharSet.decode(charset_bytes),
         {:ok, {text,    rest         }} <- TextString.decode(text_bytes)
    do
      ok {{length, charset, text}, rest}
    else
      error -> error
    end
  end

  def encode {length, charset, text} do
    with {:ok, length_bytes } <- ValueLength.encode(length),
         {:ok, charset_bytes} <- CharSet.encode(charset),
         {:ok, text_bytes   } <- TextString.encode(text)
    do
      ok length_bytes <> charset_bytes <> text_bytes
    else
      error -> error
    end
  end

  def encode text do
    text |> TextString.encode
  end
end

