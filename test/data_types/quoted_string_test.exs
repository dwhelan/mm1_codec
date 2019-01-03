defmodule MMS.QuotedStringTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.QuotedString,

      examples: [
        { <<"\"x\0">>, ~S("x") },
        { <<"\"\0">>,  ~S("")  },
      ],

      decode_errors: [
        { <<1>>,          :invalid_quoted_string },
        { <<"\"string">>, :missing_terminator    },
      ],

      encode_errors: [
        { :not_a_quoted_string, :invalid_quoted_string },
        { "\"x",                :invalid_quoted_string },
        { "x\"",                :invalid_quoted_string },
      ]
end
