defmodule MM1.Message do
  alias MM1.Codecs.Wrapper
  import Wrapper

  alias MM1.Headers

  def decode bytes do
    Wrapper.decode bytes, __MODULE__
  end

  def encode result do
    Wrapper.encode result, __MODULE__
  end

  def new value do
    Wrapper.new value, __MODULE__
  end

  def codec do
    Headers
  end
end
