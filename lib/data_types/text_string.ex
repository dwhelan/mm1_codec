defmodule MMS.TextString do
  @moduledoc """
  Text-string = [Quote] *TEXT End-of-string

  If the first character in the TEXT is in the range of 128-255, a Quote character must precede it.
  Otherwise the Quote character must be omitted.
  The Quote is not part of the contents.

  Quote = <Octet 127>
  """
  use MMS.Codec
  alias MMS.Text

  @quote 127

  def decode(<<@quote, short, _::binary>> = bytes) when is_short_integer_byte(short) do
    bytes |> decode_with(Text, & String.slice(&1, 1..-1))
  end

  def decode(bytes = <<@quote, _::binary>>) do
    bytes |> decode_error(:byte_following_quote_must_be_greater_than_127)
  end

  def decode(bytes = <<text, _::binary>>) when is_text(text) and text != @quote do
    bytes |> decode_with(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_error(:first_byte_must_be_a_char_or_quote)
  end

  def encode(string = <<short, _::binary>>) when is_short_integer_byte(short) do
    (<<@quote>> <> string) |> encode_with(Text)
  end

  def encode(string) when is_binary(string) do
    string |> encode_with(Text)
  end
end
