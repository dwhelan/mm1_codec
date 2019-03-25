defmodule MMS.FieldName do
  @moduledoc """
  8.4.2.6 Header

  Field-name = Token-text | Well-known-field-name

  This encoding is used for token values, which have no well-known binary encoding, or when
  the assigned number of the well-known encoding is small enough to fit into Short-integer.
  """
  use MMS.Codec

  alias MMS.{TokenText, WellKnownFieldName}

  def decode(<<char, _ :: binary>> = bytes) when is_token_char(char) do
    bytes
    |> decode_as(TokenText)
  end

  def decode(bytes = <<byte, _::binary>>) when is_short_integer_byte(byte) do
    bytes
    |> decode_as(WellKnownFieldName)
  end

  def decode(bytes = <<octet, _::binary>>) do
    bytes
    |> decode_error(out_of_range: octet)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(TokenText)
  end

  def encode(short_integer) when is_short_integer(short_integer) do
    short_integer
    |> encode_as(WellKnownFieldName)
  end

  def encode value do
    value
    |> encode_error(:out_of_range)
  end
end
