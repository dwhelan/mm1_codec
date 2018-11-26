defmodule WAP.ShortLength do
  use MM1.BaseCodec

  import WAP.Guards

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    value value, <<value>>, rest
  end

  def decode <<value, rest::binary>> do
    _error value, <<value>>, rest
  end

  def new(value) when is_short_length(value) do
    value value, <<value>>
  end

  def new value do
    _error value
  end

  defp _error value, bytes \\ <<>>, rest \\ <<>> do
    error :must_be_an_integer_between_0_and_30, value, bytes, rest
  end
end
