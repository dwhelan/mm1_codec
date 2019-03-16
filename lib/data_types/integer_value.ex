defmodule MMS.IntegerValue do
  @moduledoc """
  Specification: WAP-230230-WSP-20010705-a, 8.4.2.3 Parameter Values

  Integer-Value = Short-integer | Long-integer
  """
  use MMS.Codec

  alias MMS.{ShortInteger, LongInteger}

  def decode(bytes = <<byte, _::binary>>) when is_short_integer_byte(byte) do
    bytes |> decode_as(ShortInteger)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_as(LongInteger)
  end

  def encode(value) when is_short_integer(value) do
    value |> encode_as(ShortInteger)
  end

  def encode(value) when is_integer(value) do
    value |> encode_as(LongInteger)
  end
end
