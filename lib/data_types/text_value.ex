defmodule MMS.TextValue do
  @moduledoc """
  Text-value = No-value | Token-text | Quoted-string

  Note: we use Text as for our purposes it is equivalent to Token-text
  """
  use MMS.Codec2

  alias MMS.{NoValue, QuotedString, Text}

  def decode(no_value = <<byte, _::binary>>) when is_no_value_byte(byte) do
    no_value |> decode_with(NoValue)
  end

  def decode(quoted_string = <<quote, _::binary >>) when is_quote(quote) do
    quoted_string |> decode_with(QuotedString)
  end

  def decode(text = <<char, _::binary>>) when is_char(char) do
    text |> decode_with(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> error(:first_byte_must_be_no_value_or_quote_or_char)
  end

  def encode(no_value) when is_no_value(no_value) do
    no_value |> encode_with(NoValue)
  end

  def encode(quoted_string = << quote, _::binary >>) when is_quote(quote) do
    quoted_string |> encode_with(QuotedString)
  end

  def encode(text = <<char, _::binary>>) when is_char(char) do
    text |> encode_with(Text)
  end

  def encode(string) when is_binary(string) do
    string |> error(:first_byte_must_be_no_value_or_quote_or_char)
  end
end
