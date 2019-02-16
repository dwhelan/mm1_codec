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
        { <<1>>,        {:invalid_text_value, <<1>>,        :must_be_no_value_quoted_string_or_text} },
        { <<128>>,      {:invalid_text_value, <<128>>,      :must_be_no_value_quoted_string_or_text} },
        { <<"x">>,      {:invalid_text_value, <<"x">>,      :missing_end_of_string_byte_of_0}        },
        { << ~s("x) >>, {:invalid_text_value, << ~s("x) >>, :missing_end_of_string_byte_of_0}        },
      ],

      encode_errors: [
        {<<1>>, {:invalid_text_value, <<1>>, :must_be_no_value_quoted_string_or_text}}
      ]
end
