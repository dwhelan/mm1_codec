defmodule MMS.EncodedStringTest do
  use ExUnit.Case

  alias MMS.EncodedString

  string30 = String.duplicate("x", 30)

  use MMS.TestExamples,
      codec: EncodedString,
      examples: [
        # Not encoded
        {<<0>>,       ""},
        {<<"x", 0>>, "x"},

        # Encoded
        {<< 3, 0xea, "x", 0>>,              {"x", :csUTF8}},
        {<< 5, 2, 0x03, 0xe8, "x", 0>>,     {"x", :csUnicode}},

        {<<31, 32, 0xea>> <> string30 <> <<0>>, {string30, :csUTF8}},
      ],

      decode_errors: [
        {<< 2, 0xea, "x", 0>>, :incorrect_length},
        {<<"x">>,              :missing_terminator},
        {<<6, 0xea, "x">>,     :missing_terminator},
      ]
end

