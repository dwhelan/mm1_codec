defmodule MMS.TextValue do
  @moduledoc """
  Text-value = No-value | Token-text | Quoted-string
  """
  use MMS.Codec2

  alias MMS.{NoValue, QuotedString, Text}

  def reason {_, _, reason} do
    reason
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> do_decode
    ~>> fn error -> error bytes, reason(error) end
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
    error bytes, :must_be_no_value_quoted_string_or_text
  end

  def encode(:no_value) do
    :no_value |> NoValue.encode
  end

  def encode(quoted_string = << ~s("), _::binary >>) do
    quoted_string |> QuotedString.encode
  end

  def encode(text = <<byte, _::binary>>) when is_char(byte) do
    text |> Text.encode
  end

  def encode(string) when is_binary(string) do
    error string, :must_be_no_value_quoted_string_or_text
  end
end
