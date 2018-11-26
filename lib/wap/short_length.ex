defmodule WAP.ShortLength do
  use MM1.BaseCodec

  import WAP.Guards
  import MM1.Result

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    decode_ok value, <<value>>, rest
  end

  def decode <<value, rest::binary>> do
    decode_error value, <<value>>, rest, :must_be_an_integer_between_0_and_30
  end

  def new(value) when is_short_length(value) do
    new_ok value, <<value>>
  end

  def new value do
    new_error value, :must_be_an_integer_between_0_and_30
  end
end
