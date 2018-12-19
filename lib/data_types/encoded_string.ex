defmodule MMS.EncodedString do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{Composer, Length, Charset, String}

  def decode(<<byte, _::binary>> = bytes) when is_string(byte) do
    bytes |> String.decode
  end

  def decode bytes do
    Composer.decode bytes, {Charset, String}
  end

  def encode(string) when is_binary(string) do
    string |> String.encode
  end

  def encode {charset, string} do
    with {:ok, charset_bytes} <- Charset.encode(charset),
         {:ok, string_bytes } <- String.encode(string),
         {:ok, length_bytes } <- Length.encode(byte_size(charset_bytes) + byte_size(string_bytes))
    do
      ok length_bytes <> charset_bytes <> string_bytes
    else
      error -> error
    end
  end
end
