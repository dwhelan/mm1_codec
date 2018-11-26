defmodule WAP.ShortLength do
  use MM1.BaseCodec

  import WAP.Guards
  import MM1.Result

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    ok value, <<value>>, rest
  end

  def decode <<value, rest::binary>> do
     err value, :must_be_an_integer_between_0_and_30, <<value>>, rest
  end

  def new(value) when is_short_length(value) do
    ok value, <<value>>
  end

  def new value do
    err value, :must_be_an_integer_between_0_and_30
  end
end
