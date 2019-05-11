defmodule MMS.TokenTextTest do
  use MMS.CodecTest
  import MMS.TokenText

    codec_examples [
      {"", <<"string", 0>>, "string"},
    ]

    decode_errors [
      {"No Tokens",             <<0>>,          :missing_token },
      {"Missing End-of-string", <<"string">>},
      {"Invalid Token",         << "s", 1, 0>>, invalid_token: 1},
    ]

    encode_errors [
      {"1", "",      {:token_text, "",      :missing_token} },
      {"2", "x\0",   {:token_text, "x\0",   {:invalid_token, 0}}   },
      {"3", "\u{1}", {:token_text, "\u{1}", {:invalid_token, 1}}    },
      {"4", :bad_value, {:token_text, :bad_value, :out_of_range}    },
    ]
end
