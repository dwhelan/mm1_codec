defmodule WAP.ShortIntegerMap do
  @short_integer_zero 128

  def map(byte, values) when byte >= @short_integer_zero and byte < @short_integer_zero + tuple_size(values) do
    elem values, byte - @short_integer_zero
  end

  def map _, _ do
    :unknown
  end
end
