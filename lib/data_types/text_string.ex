defmodule MMS.TextString do
  @moduledoc """
  8.4.2.1 Basic rules

  Text-string = [Quote] *TEXT End-of-string

  If the first character in the TEXT is in the range of 128-255, a Quote character must precede it.
  Otherwise the Quote character must be omitted.
  The Quote is not part of the contents.

  Quote = <Octet 127>
  """
  use MMS.Codec
  import MMS.As
  alias MMS.Text

  @quote 127

  def decode(bytes = <<@quote, char, _::binary>>) when is_short_integer_byte(char) do
    bytes
    |> decode_as(Text, &remove_quote/1)
  end

  def decode(bytes = <<@quote, _::binary>>) do
    error bytes, :unnecessary_quote
  end

  def decode(bytes = <<text, _::binary>>) when is_text(text) and text != @quote do
    bytes
    |> decode_as(Text)
  end

  def decode bytes do
    error bytes, :first_byte_must_be_a_char_or_quote
  end

  def encode(string = <<short, _::binary>>) when is_short_integer_byte(short) do
    <<@quote>> <> string
    |> encode_as(Text)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(Text)
  end

  def encode value do
    super value
  end

  defp remove_quote string do
    string
    |> String.slice(1..-1)
  end
end
