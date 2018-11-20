defmodule WAP.ShortIntegerMap do
  @short_integer_zero 128

  def map(short_integer, values) when short_integer >= @short_integer_zero and short_integer < @short_integer_zero + tuple_size(values) do
    elem values, short_integer - @short_integer_zero
  end

  def map _, _ do
    :unknown
  end
end
