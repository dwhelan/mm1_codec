defmodule WAP.CharSetTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.CharSet, [
    {<<0xea>>,          :csUTF8},
    {<<2, 0x03, 0xe8>>, :csUnicode},
    {<<2, 0x0b, 0xb8>>, :reserved},
  ]
end
