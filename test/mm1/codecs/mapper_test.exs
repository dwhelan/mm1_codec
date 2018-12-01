defmodule MM1.Codecs.MapperTest do
  use ExUnit.Case

  alias MM1.Codecs.Mapper

  use Mapper,
      codec: WAP.Byte,
      map:   %{0 => false, 1 => true}

  use MM1.Codecs.BaseExamples,
      codec: __MODULE__,
      examples: [
        {<<0>>, false},
        {<<1>>, true},
        {<<2>>, 2},
      ]

  test "ordinal_map" do
    map = Mapper.ordinal_map([:a, :b])

    assert Map.get(map, 128) === :a
    assert Map.get(map, 129) === :b
  end
end
