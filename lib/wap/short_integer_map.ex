defmodule WAP.ShortIntegerMap do
  alias MM1.Result
  @short_integer_zero 128

  def map(%Result{} = result, values) do
    IO.inspect result
    %Result{result | value: map(result.value, values)}
  end

  def map(short_integer, values) when short_integer < tuple_size(values) do
    elem values, short_integer
  end
#  def map(short_integer, values) when short_integer >= @short_integer_zero and short_integer < @short_integer_zero + tuple_size(values) do
#    elem values, short_integer - @short_integer_zero
#  end

  def map _, _ do
    :unknown
  end

  def unmap value, values do
  end
end
