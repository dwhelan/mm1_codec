defmodule MM1.Message do
  alias MM1.Codecs.Wrapper
  import MM1.Codecs.Wrapper

  alias MM1.Headers

  def decode bytes do
    codec :decode, bytes
  end

  def encode result do
    codec :encode, result
  end

  def new value do
    codec :new, value
  end

  def codec function_name, arg do
    apply Wrapper, function_name, [arg, Headers, __MODULE__]
  end
end
