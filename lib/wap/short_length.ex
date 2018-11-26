defmodule WAP.ShortLength do
  use MM1.BaseCodec

  def decode(<<length, rest::binary>>) when length <= 30 do
    value length, <<length>>, rest
  end

  def decode(<<length, rest::binary>>)do
    error :must_be_less_than_31, length, <<length>>, rest
  end

  def new(length) when is_integer(length) and length >= 0 and length <= 30 do
    value length, <<length>>
  end

  def new(length) do
    error :must_be_an_integer_between_0_and_30, length
  end
end
