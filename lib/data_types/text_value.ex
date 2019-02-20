defmodule MMS.TextValue do
  @moduledoc """
  Text-value = No-value | Token-text | Quoted-string

  Note: we use Text as for our purposes it is equivalent to Token-text
  """
  use MMS.Codec2

  alias MMS.{NoValue, QuotedString, Text}

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> do_decode
    ~>> fn error -> error bytes, error end
  end

  defp do_decode(bytes = <<0, _::binary>>) do
    bytes |> NoValue.decode
  end

  defp do_decode(bytes = << ~s("), _::binary>>) do
    bytes |> QuotedString.decode
  end

  defp do_decode(bytes = <<byte, _::binary>>) when is_char(byte) do
    bytes |> Text.decode
  end

  defp do_decode(bytes) when is_binary(bytes) do
    error :first_byte_must_be_no_value_or_quote_or_char
  end

  def encode(:no_value) do
    :no_value |> NoValue.encode
  end

  def encode(string) when is_binary(string) do
    string
    |> do_encode
    ~>> fn error -> error string, error end
  end

  defp do_encode(quoted_string = << ~s("), _::binary >>) do
    quoted_string |> QuotedString.encode
  end

  defp do_encode(text = <<byte, _::binary>>) when is_char(byte) do
    text |> Text.encode
  end

  defp do_encode(string) when is_binary(string) do
    error :first_byte_must_be_no_value_or_quote_or_char
  end
end
