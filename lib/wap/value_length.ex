defmodule WAP.ValueLength do
  use MM1.BaseCodec
  alias WAP.{ShortLength, Uintvar}
  alias MM1.Result

  @length_quote 31

  def decode(<<value, _::binary>> = bytes) when is_short_length(value) do
    bytes |> ShortLength.decode |> embed
  end

  def decode <<@length_quote, bytes::binary>> do
    bytes |> Uintvar.decode |> prefix_with_length_quote |> embed
  end

  def decode <<value, rest::binary>> do
    decode_error value, :first_byte_must_be_less_than_32, <<value>>, rest
  end

  def new(value) when is_short_length(value) do
    value |> ShortLength.new |> embed
  end

  def new(value) when is_uintvar(value) do
    value |> Uintvar.new |> prefix_with_length_quote |> embed
  end

  def new value do
    new_error value, :must_be_an_unsigned_32_bit_integer
  end

  defp prefix_with_length_quote result do
    %Result{result | bytes: <<@length_quote>> <> result.bytes}
  end
end
