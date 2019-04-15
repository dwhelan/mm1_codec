defmodule MMS.TextTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Text,

      examples: [
        {<<"string\0">>, "string"},
      ],

      decode_errors: [
        {<<0>>,        {:text, <<0>>,    :must_start_with_a_char} },
        {<<1, 0>>,     {:text, <<1, 0>>, :must_start_with_a_char} },
        {<<"string">>, {:text, "string", :missing_end_of_string } },
      ],

      encode_errors: [
        {<<1, 0>>, {:text, <<1, 0>>, :must_start_with_a_char} },
        {"x\0",    {:text, "x\0",    :contains_end_of_string} },
      ]
end
