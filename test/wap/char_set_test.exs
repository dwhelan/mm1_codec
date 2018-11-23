defmodule WAP.CharSetTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.CharSet, [
    {"UTF8",     <<0xea>>,          :csUTF8},
    {"Unicode",  <<2, 0x03, 0xe8>>, :csUnicode},
    {"Reserved", <<2, 0x0b, 0xb8>>, :reserved},
  ]
end
