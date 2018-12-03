defmodule MM1.Codecs.MapperTest do
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

defmodule MM1.Codecs.OrdinalMapperTest do
  use ExUnit.Case

  alias MM1.Codecs.Mapper

  use Mapper,
      codec:  WAP.Byte,
      values: [false, true]

  use MM1.Codecs.TestExamples,
      examples: [
        {<<0>>, false},
        {<<1>>, true},
        {<<2>>, 2},
      ]
end
