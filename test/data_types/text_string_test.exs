defmodule MMS.TextStringTest do
  use ExUnit.Case

  @quote 127

  use MMS.TestExamples,
      codec: MMS.TextString,
      examples: [
        {<<0>>,                   ""            },
        {<<"x", 0>>,              "x"           },
        {<<@quote, 128, "x", 0>>, <<128>> <> "x"},
      ],

      decode_errors: [
        {<<1>>,        :invalid_text_string    },
        {<<@quote, 127, "x", 0>>, :invalid_text_string},
        {<<"string">>, :missing_terminator},
      ],

      encode_errors: [
        {:not_a_string, :invalid_text_string},
      ]
end
