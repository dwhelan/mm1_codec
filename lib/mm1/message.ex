defmodule MM1.Message do
  import MM1.Codecs.Wrapper

  alias MM1.Headers

  def decode bytes do
    decode bytes, Headers, __MODULE__
  end

  def encode result do
    encode result, Headers, __MODULE__
  end

  def new value do
    new value, Headers, __MODULE__
  end
end
