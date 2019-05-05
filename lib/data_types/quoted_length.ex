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

  defp ensure_in_range({value, rest}, bytes) when is_short_length(value) do
    error bytes, out_of_range: value
  end

  defp ensure_in_range({value, rest}, bytes) do
    ok value, rest
  end

  def encode value do
    value
    |> encode_as(Length)
    ~> fn bytes -> <<@length_quote>> <> bytes end
  end
end
