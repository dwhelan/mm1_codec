defmodule MM1.Message do
  require MM1.Headers

  use MM1.BaseCodec

   def decode bytes do
    value MM1.Headers.decode bytes
  end

  def encode value  do
    <<value>>
  end
end
