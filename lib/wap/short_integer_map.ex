defmodule WAP.ShortIntegerMap do

  def map(byte, values) when byte >= 128 and byte < 128 + tuple_size(values) do
    elem values, byte - 128
  end

  def map _, _ do
    :unknown
  end
end
