defmodule MM1.Codecs.ComposerTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  import MM1.Codecs.Composer

  use MM1.Codecs.BaseExamples,
      codec: __MODULE__,
      examples: [
        {<<0, 1>>, [0, 1]}
      ]

  def decode bytes do
    decode bytes, Byte, Byte, __MODULE__
  end

  def encode result do
    encode result, Byte, Byte, __MODULE__
  end

  def new value do
    new value, Byte, Byte, __MODULE__
  end
end
