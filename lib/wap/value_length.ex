defmodule WAP.ValueLength do
  use MM1.Codecs.Default
  alias WAP.{ShortLength, Uintvar}
  alias MM1.Result

  @length_quote 31

  def decode(<<value, _::binary>> = bytes) when is_short_length(value) do
    bytes |> ShortLength.decode |> set_module
  end

  def decode <<@length_quote, bytes::binary>> do
    bytes |> Uintvar.decode |> prefix_with_length_quote |> set_module
  end

  def decode <<value, rest::binary>> do
    decode_error :first_byte_must_be_less_than_32, value, <<value>>, rest
  end

  def new(value) when is_short_length(value) do
    value |> ShortLength.new |> set_module
  end

  def new(value) when is_uintvar(value) do
    value |> Uintvar.new |> prefix_with_length_quote |> set_module
  end

  def new value do
    new_error :must_be_an_unsigned_32_bit_integer, value
  end

  defp prefix_with_length_quote result do
    %Result{result | bytes: <<@length_quote>> <> result.bytes}
  end
end
