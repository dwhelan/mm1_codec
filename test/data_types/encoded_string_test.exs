defmodule MMS.EncodedStringTest do
  use ExUnit.Case
  import MMS.Test

  string30     = String.duplicate "x", 30
  length_quote = 31

  use MMS.TestExamples,
      codec: MMS.EncodedString,
      examples: [
        # Not encoded
        { <<0>>,     ""  },
        { <<"x\0">>, "x" },

        # Encoded with short length
        { << l(3), s(106), "x\0" >>,            {"x", :csUTF8,  } },
        { << l(5), l(2), 1000::16, "x\0" >>, {"x", :csUnicode} },

        # Encoded with uint32 length
        { << length_quote, l(32), s(106) >> <> string30 <> <<0>>, {string30, :csUTF8} },
      ],

      decode_errors: [
        { <<"x">>,               :missing_terminator },
        { <<l(2), s(106), "x">>, :missing_terminator },

        { << l(2), s(106), "x\0">>,                              :incorrect_length }, #  short length
        { << length_quote, l(33), s(106)>> <> string30 <> <<0>>, :incorrect_length }, # uint32 length
      ]
end

