defmodule MMS.TextValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.TextValue,

      examples: [
        { <<0>>,          :no_value },
        { <<"x\0">>,      "x"       },
        { << ~s("x\0) >>, ~s("x)    },
      ],

      decode_errors: [
        { <<1>>,        {:text_value, <<1>>,        [no_value: [out_of_range: 1],   token_text: [:text, :must_start_with_a_char], quoted_string: :must_start_with_a_quote]} },
        { <<128>>,      {:text_value, <<128>>,      [no_value: [out_of_range: 128], token_text: [:text, :must_start_with_a_char], quoted_string: :must_start_with_a_quote]} },
        { <<"x">>,      {:text_value, <<"x">>,      [no_value: [out_of_range: 120], token_text: [:text, :missing_end_of_string],               quoted_string: :must_start_with_a_quote]}                 },
        { << ~s("x) >>, {:text_value, << ~s("x) >>, [no_value: [out_of_range: 34],  token_text: [:text, :missing_end_of_string],               quoted_string: [:text, :missing_end_of_string]]} },
      ],

      encode_errors: [
        { <<1>>,    {:text_value, <<1>>,      [no_value: :out_of_range, token_text: {:invalid_token_char, 1},   quoted_string: :must_start_with_a_quote]}},
        { <<128>>,  {:text_value, <<128>>,    [no_value: :out_of_range, token_text: {:invalid_token_char, 128}, quoted_string: :must_start_with_a_quote]}},
        { "x\0",    {:text_value, <<120, 0>>, [no_value: :out_of_range, token_text: {:invalid_token_char, 0},   quoted_string: :must_start_with_a_quote]}},
        { ~s("x\0), {:text_value, ~s("x\0),   [no_value: :out_of_range, token_text: {:invalid_token_char, 34}, quoted_string: [:text, :contains_end_of_string]]}},
      ]
end
