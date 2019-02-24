defmodule MMS.TextValue do
  @moduledoc """
  Text-value = No-value | Token-text | Quoted-string

  Note: we use Text as for our purposes it is equivalent to Token-text
  """
  use MMS.Codec2

  alias MMS.{NoValue, QuotedString, Text}

  def decode(no_value = <<0, _::binary>>) do
    no_value |> decode_with(NoValue)
  end

  def decode(quoted_string = << ~s("), _::binary>>) do
    quoted_string |> decode_with(QuotedString)
  end

  def decode(text = <<char, _::binary>>) when is_char(char) do
    text |> decode_with(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> error(:first_byte_must_be_no_value_or_quote_or_char)
  end

  def encode :no_value do
    :no_value
    |> NoValue.encode
  end

  def encode(string) when is_binary(string) do
    string
    |> do_encode
    ~>> fn error -> encode_error string, error end
  end

  defp do_encode(quoted_string = << quote, _::binary >>) when is_quote(quote) do
    quoted_string
    |> QuotedString.encode
  end

  defp do_encode(text = <<byte, _::binary>>) when is_char(byte) do
    text
    |> Text.encode
  end

  defp do_encode(string) when is_binary(string) do
    error :first_byte_must_be_no_value_or_quote_or_char
  end
end
