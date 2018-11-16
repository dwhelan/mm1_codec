defmodule MM1.Message do
  require MM1.Headers

  use MM1.BaseCodec

   def decode bytes do
    return %Result{value: MM1.Headers.decode bytes}
  end

  def encode %Result{}  do
    <<0>>
  end
end
