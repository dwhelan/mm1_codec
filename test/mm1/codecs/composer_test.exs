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
    decode bytes, __MODULE__, Byte, Byte
  end

  def encode result do
    encode result, __MODULE__, Byte, Byte
  end

  def new values do
    new values, __MODULE__, Byte, Byte
  end
end
