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
        { <<1>>,        {:invalid_text_value, <<1>>,        :first_byte_must_be_no_value_or_quote_or_char} },
        { <<128>>,      {:invalid_text_value, <<128>>,      :first_byte_must_be_no_value_or_quote_or_char} },
        { <<"x">>,      {:invalid_text_value, <<"x">>,      [:invalid_text, :missing_end_of_string_0_byte]}                 },
        { << ~s("x) >>, {:invalid_text_value, << ~s("x) >>, [:invalid_quoted_string, :invalid_text, :missing_end_of_string_0_byte]}                 },
      ],

      encode_errors: [
        { <<1>>,    {:invalid_text_value, <<1>>,      :first_byte_must_be_no_value_or_quote_or_char}},
        { <<128>>,  {:invalid_text_value, <<128>>,    :first_byte_must_be_no_value_or_quote_or_char}},
        { "x\0",    {:invalid_text_value, <<120, 0>>, [:invalid_text, :contains_end_of_string_0]}               },
        { ~s("x\0), {:invalid_text_value, ~s("x\0),   [:invalid_quoted_string, :invalid_text, :contains_end_of_string_0]}               },
      ]
end
