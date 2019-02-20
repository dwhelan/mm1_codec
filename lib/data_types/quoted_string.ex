defmodule MMS.QuotedString do
  @moduledoc """
  Quoted-string = <Octet 34> *TEXT End-of-string

  The TEXT encodes an RFC2616 Quoted-string with the enclosing quotation-marks <"> removed.

  <Octet 34> = "
  """
  use MMS.Codec2

  alias MMS.Text

  def decode(bytes = << quote, _::binary >>) when is_quote(quote) do
    bytes
    |> Text.decode
    ~>> fn error -> decode_error bytes, error end
  end

  def decode(bytes) when is_binary(bytes) do
    decode_error bytes, :must_start_with_a_quote
  end

  def encode(string = << quote, _::binary >>) when is_quote(quote) do
    string
    |> Text.encode
    ~>> fn error -> encode_error string, error end
  end

  def encode(string) when is_binary(string) do
    encode_error string, :must_start_with_a_quote
  end
end
