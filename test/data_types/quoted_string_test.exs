defmodule MMS.QuotedStringTest do
  use ExUnit.Case

  @quote_char 34

  use MMS.TestExamples,
      codec: MMS.QuotedString,
      examples: [
        {<<@quote_char, 0>>,      {""}  },
        {<<@quote_char, "x", 0>>, {"x"} },
      ],

      decode_errors: [
        {<<1>>,        :invalid_quoted_string    },
        {<<@quote_char, "string">>, :missing_terminator},
      ],

      encode_errors: [
        {:not_a_quoted_string, :invalid_quoted_string},
      ]
end
