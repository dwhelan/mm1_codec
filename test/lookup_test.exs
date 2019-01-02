defmodule MMS.LookupWithMapTest do
  use ExUnit.Case

  use MMS.Lookup, codec: MMS.Short, map: %{0 => false, 1 => true}

  use MMS.TestExamples,
      examples: [
        { <<128>>, false },
        { <<129>>, true  },
      ],

      decode_errors: [
        { <<127>>, :invalid_lookup_with_map_test },
        { <<130>>, :invalid_lookup_with_map_test },
      ],

      encode_errors: [
        { -1, :invalid_lookup_with_map_test },
      ]
end

defmodule MMS.LookupWithValuesTest do
  use ExUnit.Case

  use MMS.Lookup, codec: MMS.Short, values: [false, true]

  use MMS.TestExamples,
      examples: [
        { <<128>>, false },
        { <<129>>, true  },
      ],

      decode_errors: [
        { <<127>>, :invalid_lookup_with_values_test },
        { <<130>>, :invalid_lookup_with_values_test },
      ],

      encode_errors: [
        {-1, :invalid_lookup_with_values_test},
      ]
end

defmodule MMS.Lookup.Test do
  use ExUnit.Case
  import MMS.Lookup
  
#  test "reverse" do
#    assert reverse(%{a: 0, b: 1}) == %{0 => :a, 1 => :b}
#  end
#
  test "indexed" do
    assert indexed([:a, :b]) == %{0 => :a, 1 => :b}
  end
end
