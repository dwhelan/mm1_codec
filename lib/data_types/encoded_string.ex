defmodule MMS.EncodedString do
  import MM1.OkError
  import MMS.DataTypes

  alias MMS.{ValueLength, CharSet, TextString}

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

