defmodule MM1.Message do
  use MM1.BaseCodec
  alias MM1.Headers

   def decode bytes do
    value Headers.decode bytes
  end

  def encode result do
    Headers.encode result.value
  end
end
