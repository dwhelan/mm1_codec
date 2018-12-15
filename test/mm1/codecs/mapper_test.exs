defmodule MM1.Codecs2.Mapper.UseWithMapTest do
  use ExUnit.Case

  alias MMS.ShortLength

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

  alias MMS.ShortLength

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

  alias MMS.ShortLength
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
