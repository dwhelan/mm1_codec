defmodule MMS.CharSetTest do
  use ExUnit.Case

  use MM1.Codecs2.TestExamples,
      codec: MMS.CharSet,
      examples: [
        {<<0xea>>,          {:csUTF8, <<>>}},
        {<<2, 0x03, 0xe8>>, {:csUnicode, <<>>}},
#        {<<2, 0x0b, 0xb8>>, {:reserved, <<>>}},
      ]

#      new_errors: [
#        {-1, :must_be_an_integer_greater_than_or_equal_to_0},
#        {1.23, :must_be_an_integer_greater_than_or_equal_to_0},
#        {"x", :must_be_an_integer_greater_than_or_equal_to_0},
#        {:foo, :unknown_char_set},
#      ]
end


