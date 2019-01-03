defmodule MMS.QuotedStringTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.QuotedString,

      examples: [
        { <<"\"x\0">>, ~S("x") },
        { <<"\"\0">>,  ~S("")  },
      ],

      decode_errors: [
        { <<1>>,          :invalid_quoted_string }, # does not start with text byte
        { <<"\"string">>, :invalid_quoted_string }, # missing terminator
      ],

      encode_errors: [
        { :not_a_quoted_string, :invalid_quoted_string },
        { ~S("x),               :invalid_quoted_string },
        { ~S(x"),               :invalid_quoted_string },
      ]
end
