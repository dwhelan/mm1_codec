defmodule WAP.ShortIntegerMap do
  alias MM1.Result

  def map(%Result{} = result, values) do
    %Result{result | value: map(result.value, values)}
  end

  def map(short_integer, values) when short_integer < tuple_size(values) do
    elem values, short_integer
  end
end
