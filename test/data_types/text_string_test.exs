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
        { <<@quote, 127, "x\0">>, {:text_string, <<@quote, 127, "x\0">>, :octet_following_quote_must_be_greater_than_127} },
        { <<"string">>,           {:text_string, <<"string">>,           [:text, :missing_end_of_string]} },
        { <<1>>,                  {:text_string, <<1>>,                  :first_byte_must_be_a_char_or_quote}            },
      ],

      encode_errors: [
      ]
end
