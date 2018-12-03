defmodule MM1.Codecs.Mapper.MapTest do
  use ExUnit.Case

  alias MM1.Codecs.Mapper

  use Mapper,
      codec: WAP.Byte,
      map:   %{0 => false, 1 => true}

  use MM1.Codecs.TestExamples,
      examples: [
        {<<0>>, false},
        {<<1>>, true},
        {<<2>>, 2},
      ]
end

defmodule MM1.Codecs.Mapper.ListTest do
  use ExUnit.Case

  alias MM1.Codecs.Mapper

  use Mapper,
      codec:  WAP.Byte,
      map:    [false, true]

  use MM1.Codecs.TestExamples,
      examples: [
        {<<0>>, false},
        {<<1>>, true},
        {<<2>>, 2},
      ]
end

defmodule MM1.Codecs.Mapper.ImportTest do
  use ExUnit.Case

  import MM1.Codecs.Mapper

  def decode bytes do
    decode bytes, __MODULE__
  end

  def encode result do
    encode result, __MODULE__
  end

  def new values do
    new values, __MODULE__
  end

  def codec do
    WAP.Byte
  end

  def map result_value do
    case result_value do
      0     -> false
      1     -> true
      value -> value
    end
  end

  def unmap mapped_value do
    case mapped_value do
      false -> 0
      true  -> 1
      value -> value
    end
  end

  use MM1.Codecs.TestExamples,
      examples: [
        {<<0>>, false},
        {<<1>>, true},
        {<<2>>, 2},
      ]
end
