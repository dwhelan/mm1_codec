defmodule MMS.TextTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Text,

      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<1, 0>>,     {:invalid_text, <<1, 0>>, :first_byte_must_be_a_char} },
        {<<"string">>, {:invalid_text, "string", :missing_terminator}        },
      ],

      encode_errors: [
        {<<1, 0>>, {:invalid_text, <<1, 0>>,   :first_byte_must_be_a_char}   },
        {"x\0",    {:invalid_text, <<120, 0>>, :cannot_have_terminator_char} },
      ]
end
