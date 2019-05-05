defmodule MMS.QuotedLength do
  @moduledoc """
  We define:
  Quoted-length = Length-quote Length

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
  end

  def decode bytes do
    error bytes, :does_not_start_with_a_length_quote
  end

  def encode value do
    value
    |> encode_as(Length)
    ~> fn bytes -> <<@length_quote>> <> bytes end
  end
end
