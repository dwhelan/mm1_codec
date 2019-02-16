defmodule MMS.QuotedString do
  @moduledoc """
  Quoted-string = <Octet 34> *TEXT End-of-string

  The TEXT encodes an RFC2616 Quoted-string with the enclosing quotation-marks <"> removed.

  <Octet 34> = "
  """
  use MMS.Codec2

  alias MMS.Text

  def decode bytes = << ~s("), _::binary >> do
    bytes
    |> Text.decode
    ~>> fn {_, _, reason} -> error bytes, reason end
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :must_start_with_a_quote
  end

  def encode string = << ~s("), _::binary >> do
    string
    |> Text.encode
    ~>> fn {_, _, reason} -> error string, reason end
  end

  def encode(string) when is_binary(string) do
    error string, :must_start_with_a_quote
  end
end
