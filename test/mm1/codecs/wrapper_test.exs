defmodule MM1.Codecs.WrapperTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  import MM1.Codecs.Wrapper

  use MM1.Codecs.BaseExamples,
      codec: __MODULE__,
      examples: [
        {<<0>>, %Result{module: Byte, value: 0, bytes: <<0>>}}
      ]

  def decode bytes do
    decode bytes, Byte, __MODULE__
  end

  def encode result do
    encode result, Byte, __MODULE__
  end

  def new value do
    new value, Byte, __MODULE__
  end
end
