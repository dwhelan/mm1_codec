defmodule MMS.QuotedString do
  @moduledoc """
  8.4.2.1 Basic rules

  Quoted-string = <Octet 34> *TEXT End-of-string

  The TEXT encodes an RFC2616 Quoted-string with the enclosing quotation-marks <"> removed.

  <Octet 34> = "
  """
  use MMS.Codec
  import MMS.As

  alias MMS.Text

  def decode(bytes = <<quote, _::binary>>) when is_quote(quote) do
    bytes
    |> decode_as(Text)
  end

  def decode bytes do
    error bytes, :must_start_with_a_quote
  end

  def encode(string = <<quote, _::binary>>) when is_quote(quote) do
    string
    |> encode_as(Text)
  end

  def encode(string) when is_binary(string) do
    error string, :must_start_with_a_quote
  end

  def encode value do
    super value
  end
end
