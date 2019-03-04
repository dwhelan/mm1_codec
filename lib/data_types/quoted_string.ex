defmodule MMS.QuotedString do
  @moduledoc """
  Quoted-string = <Octet 34> *TEXT End-of-string

  The TEXT encodes an RFC2616 Quoted-string with the enclosing quotation-marks <"> removed.

  <Octet 34> = "
  """
  use MMS.Codec

  alias MMS.Text

  def decode(bytes = << quote, _::binary >>) when is_quote(quote) do
    bytes |> decode_with(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_error(:must_start_with_a_quote)
  end

  def encode(string = << quote, _::binary >>) when is_quote(quote) do
    string |> encode_with(Text)
  end

  def encode(string) when is_binary(string) do
    string |> encode_error(:must_start_with_a_quote)
  end
end
