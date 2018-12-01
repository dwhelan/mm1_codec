defmodule MM1.Codecs.MapperTest do
  use ExUnit.Case

  use MM1.Codecs.Mapper,
      codec: WAP.Byte,
      map:   %{0 => false, 1 => true}

  use MM1.Codecs.BaseExamples,
      codec: __MODULE__,
      examples: [
        {<<0>>, false},
        {<<1>>, true},
        {<<2>>, 2},
      ]
end
