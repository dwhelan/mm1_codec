defmodule WAP2.ShortLength do
  import MM1.OkError
  import WAP.Guards

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    ok {value, rest}
  end

  def decode bytes do
    error :must_be_an_integer_between_0_and_30
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  def encode value do
    error :must_be_an_integer_between_0_and_30
  end
end
