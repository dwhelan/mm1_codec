defmodule MMS.TextStringTest do
  use MMS.CodecTest

  @quote 127

  use MMS.TestExamples,
      codec: MMS.TextString,

      examples: [
        { "\0",                   ""           },
        { "x\0",                  "x"          },
        { <<@quote, 128, "x\0">>, <<128, "x">> },
      ],

      decode_errors: [
        { <<@quote, 127, "x\0">>, {:invalid_text_string, <<@quote, 127, "x\0">>, :byte_following_quote_must_be_greater_than_127} },
        { <<"string">>,           {:invalid_text_string, <<"string">>,           :missing_end_of_string_0_byte}                    },
        { <<1>>,                  {:invalid_text_string, <<1>>,                  :first_byte_must_be_a_char_or_quote}            },
      ],

      encode_errors: [
      ]
end
