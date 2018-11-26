defmodule WAP.CharSetTest do
  use ExUnit.Case

  use MM1.CodecExamples, module: WAP.CharSet,
    examples: [
      {<<0xea>>,          :csUTF8},
      {<<2, 0x03, 0xe8>>, :csUnicode},
      {<<2, 0x0b, 0xb8>>, :reserved},
#      {<<3, 0x0b, 0xb8>>, :reserved},
    ]
end
