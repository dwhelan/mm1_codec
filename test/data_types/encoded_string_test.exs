defmodule MMS.EncodedStringTest do
  use ExUnit.Case

  alias MMS.EncodedString

  string30     = String.duplicate "x", 30
  length_quote = 31

  use MMS.TestExamples,
      codec: EncodedString,
      examples: [
        # Not encoded
        {<<0>>,       ""},
        {<<"x", 0>>, "x"},

        # Encoded with short length
        {<< 3, 0xea, "x", 0>>,          {"x", :csUTF8   }},
        {<< 5, 2, 0x03, 0xe8, "x", 0>>, {"x", :csUnicode}},

        # Encoded with uint32 length
        {<<length_quote, 32, 0xea>> <> string30 <> <<0>>, {string30, :csUTF8}},
      ],

      decode_errors: [
        {<<3, 0xea, "x">>, {MMS.String, :missing_terminator}},
        {<<"x">>,          :missing_terminator},

        {<<2, 0xea, "x", 0>>,                             :incorrect_length}, #  short length
        {<<length_quote, 33, 0xea>> <> string30 <> <<0>>, :incorrect_length}, # uint32 length
      ]
end

