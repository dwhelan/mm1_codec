defmodule MMS.ValueLength do
  alias MMS.{ShortLength, Uintvar}

  import MM1.OkError
  import MMS.DataTypes

  @length_quote 31

  def decode(<<value, _::binary>> = bytes) when is_short_length(value) do
    bytes |> ShortLength.decode
  end

  def decode <<@length_quote, rest::binary>> do
    rest |> Uintvar.decode
  end

  def decode <<value, rest::binary>> do
    error :first_byte_must_be_less_than_32
  end

  def encode(value) when is_short_length(value) do
    value |> ShortLength.encode
  end

  def encode(value) when is_uintvar(value) do
    ok value |> Uintvar.encode |> prefix_with_length_quote
  end

  def encode value do
    error :must_be_an_unsigned_32_bit_integer
  end

  defp prefix_with_length_quote {:ok, bytes} do
    <<@length_quote>> <> bytes
  end
end
