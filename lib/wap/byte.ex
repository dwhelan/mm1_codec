defmodule WAP.Byte do
  use MM1.BaseCodec

  def decode <<value, rest::binary>> do
    value value, <<value>>, rest
  end

  def new(value) when is_integer(value) and value >= 0 and value <= 255 do
    value value, <<value>>
  end

  def new value do
    error :must_be_an_integer_between_0_and_255, value
  end
end
