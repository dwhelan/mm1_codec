defmodule MMS.EncodedString do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{ValueLength, Charset, String}

  def decode(<<byte, _::binary>> = bytes) when is_string(byte) do
    bytes |> String.decode
  end

  def decode bytes do
    with {:ok, {length,  charset_bytes}} <- ValueLength.decode(bytes),
         {:ok, {charset, string_bytes }} <- Charset.decode(charset_bytes),
         {:ok, {string,  rest         }} <- String.decode(string_bytes)
    do
      ok {length, charset, string}, rest
    else
      error -> error
    end
  end

  def encode {length, charset, string} do
    with {:ok, length_bytes } <- ValueLength.encode(length),
         {:ok, charset_bytes} <- Charset.encode(charset),
         {:ok, string_bytes } <- String.encode(string)
    do
      ok length_bytes <> charset_bytes <> string_bytes
    else
      error -> error
    end
  end

  def encode string do
    string |> String.encode
  end
end
