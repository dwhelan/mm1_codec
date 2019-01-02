defmodule MMS.Lookup.UseWithMapTest do
  use ExUnit.Case

  use MMS.Lookup, codec: MMS.Short, map: %{0 => false, 1 => true}

  use MMS.TestExamples,
      examples: [
        { <<128>>, false },
        { <<129>>, true  },
      ],

      decode_errors: [
        { <<127>>, :invalid_use_with_map_test },
        { <<130>>, :invalid_use_with_map_test },
      ],

      encode_errors: [
        { -1, :invalid_short },
      ]
end

defmodule MMS.Lookup.UseWithValuesTest do
  use ExUnit.Case

  use MMS.Lookup, codec: MMS.Short, values: [false, true]

  use MMS.TestExamples,
      examples: [
        { <<128>>, false },
        { <<129>>, true  },
      ],

      decode_errors: [
        { <<127>>, :invalid_use_with_values_test },
        { <<130>>, :invalid_use_with_values_test },
      ],

      encode_errors: [
        {-1, :invalid_short},
      ]
end

defmodule MMS.Lookup.Test do
  use ExUnit.Case

  alias MMS.Short
  alias MMS.{Lookup, Mapper}
  import Lookup

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
      ],

      decode_errors: [
        {<<127>>, :invalid_short},
        {<<130>>, :invalid_lookup},
      ],

      encode_errors: [
        {-1, :invalid_short},
      ]

#  test "reverse" do
#    assert reverse(%{a: 0, b: 1}) == %{0 => :a, 1 => :b}
#  end
#
  test "indexed" do
    assert indexed([:a, :b]) == %{0 => :a, 1 => :b}
  end
end
