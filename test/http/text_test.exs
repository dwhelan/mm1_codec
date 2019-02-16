defmodule MMS.TextTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: HTTP.Text,

      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<1, 0>>,     {:invalid_text, <<1, 0>>, :first_byte_must_be_a_char}       },
        {<<"string">>, {:invalid_text, "string", :missing_end_of_string_byte_of_0} },
      ],

      encode_errors: [
        {<<1, 0>>, {:invalid_text, <<1, 0>>,   :first_byte_must_be_a_char}   },
        {"x\0",    {:invalid_text, <<120, 0>>, :contain_end_of_string_byte_of_0} },
      ]
end
