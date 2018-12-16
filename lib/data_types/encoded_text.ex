defmodule MMS.EncodedText do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{ValueLength, Charset, String}

  def decode(<<byte, _::binary>> = bytes) when is_text(byte) do
    bytes |> String.decode
  end

  def decode bytes do
    with {:ok, {length,  charset_bytes}} <- ValueLength.decode(bytes),
         {:ok, {charset, text_bytes   }} <- Charset.decode(charset_bytes),
         {:ok, {text,    rest         }} <- String.decode(text_bytes)
    do
      ok {length, charset, text}, rest
    else
      error -> error
    end
  end

  def encode {length, charset, text} do
    with {:ok, length_bytes } <- ValueLength.encode(length),
         {:ok, charset_bytes} <- Charset.encode(charset),
         {:ok, text_bytes   } <- String.encode(text)
    do
      ok length_bytes <> charset_bytes <> text_bytes
    else
      error -> error
    end
  end

  def encode text do
    text |> String.encode
  end
end
