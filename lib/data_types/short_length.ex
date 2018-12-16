defmodule MMS.ShortLength do
  import MMS.OkError
  import MMS.DataTypes

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    ok value, rest
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
