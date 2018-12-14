defmodule MM1.Codecs.Mapper.CreateTest do
  use ExUnit.Case

  alias MM1.Codecs.Mapper
  alias MM1.Codecs.Mapper.ByteMapper
  import Mapper

  create ByteMapper, codec: WAP.Byte, map: %{0 => false, 1 => true}

  use MM1.Codecs.TestExamples,
      codec: ByteMapper,
      examples: [
        {<<0>>, false},
        {<<1>>, true},
        {<<2>>, 2},
      ]
end

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

defmodule MM1.Codecs2.Mapper.UseWithMapTest do
  use ExUnit.Case

  alias WAP2.ShortLength

  use MM1.Codecs2.Mapper, codec: ShortLength, map: %{0 => false, 1 => true}

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<0>>, {false, <<>>}},
        {<<1>>, { true, <<>>}},
        {<<2>>, {    2, <<>>}},
      ],

      decode_errors: [
        {<<31>>, :must_be_an_integer_between_0_and_30},
      ],

      encode_errors: [
        {-1, :must_be_an_integer_between_0_and_30},
      ]
end

defmodule MM1.Codecs2.Mapper.UseWithValuesTest do
  use ExUnit.Case

  alias WAP2.ShortLength

  use MM1.Codecs2.Mapper, codec: ShortLength, values: [false, true]

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<0>>, {false, <<>>}},
        {<<1>>, { true, <<>>}},
        {<<2>>, {    2, <<>>}},
      ],

      decode_errors: [
        {<<31>>, :must_be_an_integer_between_0_and_30},
      ],

      encode_errors: [
        {-1, :must_be_an_integer_between_0_and_30},
      ]
end

defmodule MM1.Codecs2.Mapper.Test do
  use ExUnit.Case

  alias WAP2.ShortLength
  alias MM1.Codecs2.Mapper
  import Mapper

  @map %{0 => false, 1 => true}
  @reverse_map @map |> Mapper.reverse

  def decode bytes do
    bytes |> decode(ShortLength, @map)
  end

  def encode value do
    value |> encode(ShortLength, @reverse_map)
  end

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<0>>, {false, <<>>}},
        {<<1>>, { true, <<>>}},
        {<<2>>, {    2, <<>>}},
      ],

      decode_errors: [
        {<<31>>, :must_be_an_integer_between_0_and_30},
      ],

      encode_errors: [
        {-1, :must_be_an_integer_between_0_and_30},
      ]

  test "reverse" do
    assert reverse(%{a: 0, b: 1}) == %{0 => :a, 1 => :b}
  end

  test "indexed" do
    assert indexed([:a, :b]) == %{0 => :a, 1 => :b}
  end
end
