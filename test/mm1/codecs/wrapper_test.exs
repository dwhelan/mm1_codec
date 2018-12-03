defmodule MM1.Codecs.WrapperTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  import MM1.Codecs.Wrapper

  use MM1.Codecs.BaseExamples,
      examples: [
        {<<0>>, %Result{module: Byte, value: 0, bytes: <<0>>}}
      ]

  def decode bytes do
    decode bytes, __MODULE__, Byte
  end

  def encode result do
    encode result, __MODULE__, Byte
  end

  def new value do
    new value, __MODULE__, Byte
  end
end
