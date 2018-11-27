defmodule WAP.ValueLength do
  use MM1.BaseCodec
  alias WAP.{ShortLength, Uintvar}

  import WAP.Guards
  import MM1.Result

  @length_quote 31

  def decode(<<value, _::binary>> = bytes) when is_short_length(value) do
    bytes |> ShortLength.decode |> return
  end

  def decode <<@length_quote, bytes::binary>> do
    bytes |> Uintvar.decode |> prefix_with_length_quote |> return
  end

  def decode <<value, rest::binary>> do
    error2 value, :first_byte_must_be_less_than_32, <<value>>, rest
  end

  def new(value) when is_short_length(value) do
    value |> ShortLength.new |> return
  end

  def new(value) when is_uintvar(value) do
    value |> Uintvar.new |> prefix_with_length_quote |> return
  end

  def new value do
    error2 value, :must_be_an_unsigned_32_bit_integer
  end

  defp prefix_with_length_quote result do
    %Result{result | bytes: <<@length_quote>> <> result.bytes}
  end
end
