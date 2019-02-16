defmodule MMS.TextValue do
  use MMS.Codec2

  alias MMS.{NoValue, QuotedString, Text}

  def decode(bytes = <<no_value, _::binary>>) when is_no_value_byte(no_value) do
    bytes |> NoValue.decode
  end

  def decode(bytes = <<quote, _::binary>>) when is_quote(quote) do
    bytes |> QuotedString.decode
  end

  def decode(bytes = <<byte, _::binary>>) when is_char(byte) do
    bytes |> Text.decode
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :must_be_no_value_quoted_string_or_a_char
  end

  def encode(no_value) when is_no_value(no_value) do
    no_value |> NoValue.encode
  end

  def encode(quoted_string = <<quote, _::binary >>) when is_quote(quote) do
    quoted_string |> QuotedString.encode
  end

  def encode(text = <<byte, _::binary>>) when is_char(byte) do
    text |> Text.encode
  end

  def encode(string) when is_binary(string) do
    error string, :must_be_no_value_quoted_string_or_a_char
  end
end
