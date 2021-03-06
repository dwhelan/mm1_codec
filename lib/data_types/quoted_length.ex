defmodule MMS.QuotedLength do
  @moduledoc """
  We define:
  Quoted-length = Length-quote Length

  We enforce that Length must be greater than 30.

  8.4.2.2 Length

  Length-quote = <Octet 31>

  """
  use MMS.Codec
  import MMS.As
  alias MMS.Length

  @length_quote 31

  def decode bytes = <<@length_quote, rest::binary>> do
    rest
    |> decode_as(Length)
    ~>> fn {_, _, details} -> error bytes, details end
    ~> &ensure_in_range &1, bytes
  end

  def decode bytes do
    error bytes, :does_not_start_with_a_length_quote
  end

  defp ensure_in_range({value, rest}, _) when is_quoted_length(value) do
    ok value, rest
  end

  defp ensure_in_range {value, _}, bytes do
    error bytes, out_of_range: value
  end

  def encode(value) when is_quoted_length(value) do
    value
    |> encode_as(Length)
    ~> fn bytes -> <<@length_quote>> <> bytes end
  end

  def encode value do
    error value, :out_of_range
  end
end
