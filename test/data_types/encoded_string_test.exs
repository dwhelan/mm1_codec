defmodule MMS.EncodedStringTest do
  use MMS.Test

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
        { <<"x">>,               :invalid_encoded_string },
        { <<l(2), s(106), "x">>, :invalid_encoded_string },

        { << l(2), s(106), "x\0">>,                              :invalid_encoded_string }, #  short length
        { << length_quote, l(33), s(106)>> <> string30 <> <<0>>, :invalid_encoded_string }, # uint32 length
      ]
end

