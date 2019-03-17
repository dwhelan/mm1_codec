defmodule MMS.TokenTextTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.TokenText,

      examples: [
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<0>>,        {:token_text, <<0>>,    :must_have_at_least_one_token_char}    },
        {<<1, 0>>,     {:token_text, <<1, 0>>, :first_byte_must_be_a_token_char} },
        {<<"string">>, {:token_text, "string", [:text, :missing_end_of_string]}               },
      ],

      encode_errors: [
        {"",       {:token_text, "",       :must_have_at_least_one_character}    },
        {"x\0",    {:token_text, "x\0",    :contains_end_of_string}              },
        {<<1, 0>>, {:token_text, <<1, 0>>, :first_byte_must_be_a_zero_or_a_char} },
      ]
end
