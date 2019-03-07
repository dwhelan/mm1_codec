defmodule MMS.TextValue do
  @moduledoc """
  Text-value = No-value | Token-text | Quoted-string

  Note: we use Text as for our purposes it is equivalent to Token-text
  """
  use MMS.Codec

  alias MMS.{NoValue, QuotedString, Text}

  def decode(no_value = <<byte, _::binary>>) when is_no_value_byte(byte) do
    no_value |> decode_as(NoValue)
  end

  def decode(quoted_string = <<quote, _::binary >>) when is_quote(quote) do
    quoted_string |> decode_as(QuotedString)
  end

  def decode(text = <<char, _::binary>>) when is_char(char) do
    text |> decode_as(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_error(:first_byte_must_be_no_value_or_quote_or_char)
  end

  def encode(no_value) when is_no_value(no_value) do
    no_value |> encode_as(NoValue)
  end

  def encode(quoted_string = << quote, _::binary >>) when is_quote(quote) do
    quoted_string |> encode_as(QuotedString)
  end

  def encode(text = <<char, _::binary>>) when is_char(char) do
    text |> encode_as(Text)
  end

  def encode(string) when is_binary(string) do
    string |> encode_error(:first_byte_must_be_no_value_or_quote_or_char)
  end
end
