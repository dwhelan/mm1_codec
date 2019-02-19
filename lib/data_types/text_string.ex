defmodule MMS.TextString do
  @moduledoc """
  Text-string = [Quote] *TEXT End-of-string

  If the first character in the TEXT is in the range of 128-255, a Quote character must precede it.
  Otherwise the Quote character must be omitted.
  The Quote is not part of the contents.

  Quote = <Octet 127>
  """
  use MMS.Codec2

  alias MMS.Text

  @quote 127

  def decode(<<@quote, byte, _::binary>> = bytes) when byte >= 128 do
    bytes
    |> Text.decode
    ~> fn {text_string, rest} -> ok String.slice(text_string, 1..-1), rest end
    ~>> fn error -> error bytes, error end
  end

  def decode(<<@quote, _::binary>> = bytes) do
    error bytes, :byte_following_quote_must_be_greater_than_127
  end

  def decode(<<byte, _::binary>> = bytes) when is_text(byte) and byte != @quote do
    bytes
    |> Text.decode
    ~>> fn error -> error bytes, error end
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :first_byte_must_be_a_char_or_quote
  end

  def encode(<<byte, _::binary>> = string) when byte >= 128 do
    (<<@quote>> <> string)
    |> Text.encode
  end

  def encode(string) when is_binary(string) do
    string |> Text.encode
  end
end
