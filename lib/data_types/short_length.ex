defmodule MMS.ShortLength do
  import MMS.OkError
  import MMS.DataTypes

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    ok value, rest
  end

  def decode _ do
    error :invalid_short_length
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  def encode _ do
    error :invalid_short_length
  end
end
