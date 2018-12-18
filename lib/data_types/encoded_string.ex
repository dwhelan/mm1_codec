defmodule MMS.EncodedString do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{Length, Charset, String}

  def decode(<<byte, _::binary>> = bytes) when is_string(byte) do
    bytes |> String.decode
  end

  def decode bytes do
    with {:ok, {length,  charset_bytes}} <- Length.decode(bytes),
         {:ok, {charset, string_bytes }} <- Charset.decode(charset_bytes),
         {:ok, {string,  rest         }} <- String.decode(string_bytes),
         :ok                             <- check_length(length, charset_bytes, rest)
    do
      ok {string, charset, length}, rest
    else
      error -> error
    end
  end

  defp check_length(length, charset_bytes, rest) when length == byte_size(charset_bytes) - byte_size(rest) do
    :ok
  end

  defp check_length(length, bytes, rest)  do
    IO.inspect {:check_length, length, bytes, rest}
    {:error, :incorrect_length}
  end

  def encode {string, charset, length} do
    with {:ok, length_bytes} <- Length.encode(length),
         {:ok, data_bytes  } <- encode(string, charset)
    do
      ok length_bytes <> data_bytes
    else
      error -> error
    end
  end

  def encode {string, charset} do
    with {:ok, data_bytes} <- encode(string, charset)
    do
      ok <<byte_size(data_bytes)>> <> data_bytes
    else
      error -> error
    end
  end

  def encode string do
    string |> String.encode
  end

  defp encode string, charset do
    with {:ok, charset_bytes} <- Charset.encode(charset),
         {:ok, string_bytes } <- String.encode(string)
    do
      ok charset_bytes <> string_bytes
    else
      error -> error
    end
  end
end
