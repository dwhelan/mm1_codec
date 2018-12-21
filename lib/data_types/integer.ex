defmodule MMS.Integer do
  alias MMS.{Short, Long}

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_short_byte(byte) do
    Short.decode bytes
  end

  def decode(<<byte, _::binary>> = bytes) when is_short_length(byte) do
    Long.decode bytes
  end

  def decode _ do
    error :invalid_integer
  end

  def encode(value) when is_short(value) do
    Short.encode value
  end

  def encode(value) when is_long(value) do
    Long.encode value
  end

  def encode _ do
    error :invalid_integer
  end
end
