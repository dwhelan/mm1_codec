defmodule MMS.TextValue do
  use MMS.Codec2

  alias MMS.{NoValue, QuotedString, Text}

  @quote ~s(")

  def decode bytes = <<0, _::binary>> do
    bytes |> NoValue.decode
  end

  def decode(bytes = <<quote, _::binary>>) when is_quote(quote) do
    bytes |> QuotedString.decode
  end

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    bytes |> Text.decode
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :must_be_no_value_quoted_string_or_a_char
  end

  def encode :no_value do
    :no_value |> NoValue.encode
  end

  @quote ~s(")

  def encode quoted_string = <<@quote, _::binary >> do
    quoted_string |> QuotedString.encode
  end

  def encode(text = <<byte, _::binary>>) when is_char(byte) do
    text |> Text.encode
  end

  def encode(string) when is_binary(string) do
    error string, :must_be_no_value_quoted_string_or_a_char
  end
end
