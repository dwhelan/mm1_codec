defmodule MMS.EncodedText do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{ValueLength, Charset, Text}

  def decode(<<byte, _::binary>> = bytes) when is_text(byte) do
    bytes |> Text.decode
  end

  def decode bytes do
    with {:ok, {length,  charset_bytes}} <- ValueLength.decode(bytes),
         {:ok, {charset, text_bytes   }} <- Charset.decode(charset_bytes),
         {:ok, {text,    rest         }} <- Text.decode(text_bytes)
    do
      ok {length, charset, text}, rest
    else
      error -> error
    end
  end

  def encode {length, charset, text} do
    with {:ok, length_bytes } <- ValueLength.encode(length),
         {:ok, charset_bytes} <- Charset.encode(charset),
         {:ok, text_bytes   } <- Text.encode(text)
    do
      ok length_bytes <> charset_bytes <> text_bytes
    else
      error -> error
    end
  end

  def encode text do
    text |> Text.encode
  end
end

