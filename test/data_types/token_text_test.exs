defmodule MMS.TokenTextTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.TokenText,

      examples: [
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<0>>,          {:token_text, <<0>>,         :must_have_at_least_one_token_char} },
        {<<"string">>,   {:token_text, "string",      [:text, :missing_end_of_string]}    },
        {<< "s", 1, 0>>, {:token_text, <<"s", 1, 0>>, {:invalid_token_char, 1}}           },
      ],

      encode_errors: [
        {"",      {:token_text, "",      :must_have_at_least_one_token_char} },
        {"x\0",   {:token_text, "x\0",   {:invalid_token_char, 0}}   },
        {"\u{1}", {:token_text, "\u{1}", {:invalid_token_char, 1}}    },
        {:bad_value, {:token_text, :bad_value, :out_of_range}    },
      ]
end
