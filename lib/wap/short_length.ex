defmodule WAP.ShortLength do
  use MM1.Codecs.Base

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    decode_ok value, <<value>>, rest
  end

  def decode <<value, rest::binary>> do
    decode_error :must_be_an_integer_between_0_and_30, value, <<value>>, rest
  end

  def new(value) when is_short_length(value) do
    new_ok value, <<value>>
  end

  def new value do
    new_error :must_be_an_integer_between_0_and_30, value
  end
end

defmodule WAP2.ShortLength do
  import WAP.Guards

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    {:ok, {value, __MODULE__, rest}}
  end

  def decode bytes do
    {:error, {:must_be_an_integer_between_0_and_30, __MODULE__, bytes}}
  end

  def encode(value) when is_short_length(value) do
    {:ok, {<<value>>, __MODULE__, value}}
  end

  def encode value do
    {:error, {:must_be_an_integer_between_0_and_30, __MODULE__, value}}
  end
end
