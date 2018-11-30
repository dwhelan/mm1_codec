defmodule MM1.MapperCodecTest do
  use ExUnit.Case

  alias MM1.MapperCodec

  map = %{0 => false, 1 => true}

  use MapperCodec, codec: WAP.Byte, map: map

  use MM1.BaseDecoderExamples,
      codec: __MODULE__,
      examples: [
        {<<0>>, false}
      ]
end
