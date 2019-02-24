defmodule MMS.TextTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Text,

      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<1, 0>>,     {:text, <<1, 0>>, :first_byte_must_be_a_zero_or_a_char}       },
        {<<"string">>, {:text, "string", :missing_end_of_string} },
      ],

      encode_errors: [
        {<<1, 0>>, {:text, <<1, 0>>,   :first_byte_must_be_a_zero_or_a_char}   },
        {"x\0",    {:text, <<120, 0>>, :contains_end_of_string} },
      ]
end
