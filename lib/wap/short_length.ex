defmodule WAP.ShortLength do
  use MM1.BaseCodec

  def decode(<<length, rest::binary>>) when length <= 30 do
    value length, <<length>>, rest
  end

  def decode(<<length, rest::binary>>)do
    error :must_be_integer_less_than_31, length, <<length>>, rest
  end

  def new(length) when length <= 30 do
    value length, <<length>>
  end

  def new(length) do
    error :must_be_integer_less_than_31, length
  end
end
