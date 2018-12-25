defmodule MMS.Mapper.UseWithMapTest do
  use ExUnit.Case

  use MMS.Mapper, codec: MMS.Short, map: %{0 => false, 1 => true}

  use MMS.TestExamples,
      examples: [
        {<<128>>, false},
        {<<129>>,  true},
        {<<130>>,     2},
      ],

      decode_errors: [
        {<<127>>, :invalid_short_integer},
      ],

      encode_errors: [
        {-1, :invalid_short_integer},
      ]
end

defmodule MMS.Mapper.UseWithValuesTest do
  use ExUnit.Case

  alias MMS.Short

  use MMS.Mapper, codec: Short, values: [false, true]

  use MMS.TestExamples,
      examples: [
        {<<128>>, false},
        {<<129>>,  true},
        {<<130>>,     2},
      ],

      decode_errors: [
        {<<127>>, :invalid_short_integer},
      ],

      encode_errors: [
        {-1, :invalid_short_integer},
      ]
end

defmodule MMS.Mapper.Test do
  use ExUnit.Case

  alias MMS.Short
  alias MMS.Mapper
  import Mapper

  @decode_map %{0 => false, 1 => true}
  @encode_map Mapper.reverse @decode_map

  def decode bytes do
    bytes |> decode(Short, @decode_map)
  end

  def encode value do
    value |> encode(Short, @encode_map)
  end

  use MMS.TestExamples,
      examples: [
        {<<128>>, false},
        {<<129>>,  true},
        {<<130>>,     2},
      ],

      decode_errors: [
        {<<127>>, :invalid_short_integer},
      ],

      encode_errors: [
        {-1, :invalid_short_integer},
      ]

  test "reverse" do
    assert reverse(%{a: 0, b: 1}) == %{0 => :a, 1 => :b}
  end

  test "indexed" do
    assert indexed([:a, :b]) == %{0 => :a, 1 => :b}
  end
end