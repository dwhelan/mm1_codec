defmodule MMS.UntypedValue do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 8.4.2.4 Parameter

  Untyped-value = Integer-value | Text-value
  """
  use MMS.Codec

  alias MMS.{Integer, Text}

  def decode(bytes = <<char, _::binary>>) when is_char(char) do
    bytes |> decode_as(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_as(Integer)
  end

  def encode(string) when is_binary(string) do
    string |> encode_as(Text)
  end

  def encode(integer) when is_integer(integer) do
    integer |> encode_as(Integer)
  end
end