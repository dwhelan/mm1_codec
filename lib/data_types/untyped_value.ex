defmodule MMS.UntypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Untyped-value = Integer-value | Text-value
  """
  use MMS.Codec
  import MMS.As

  alias MMS.{IntegerValue, TextValue}

  def decode(bytes = <<char, _::binary>>) when is_char(char) do
    bytes
    |> decode_as(TextValue)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_as(IntegerValue)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(TextValue)
  end

  def encode(integer) when is_integer(integer) do
    integer
    |> encode_as(IntegerValue)
  end
end
