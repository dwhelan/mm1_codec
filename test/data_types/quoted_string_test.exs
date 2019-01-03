defmodule MMS.QuotedStringTest do
  use MMS.Test

  use MMS.TestExamples,
      codec: MMS.QuotedString,

      examples: [
        { ~s("\0),  ~S("")  },
        { ~s("x\0), ~s("x") },
      ],

      decode_errors: [
        { <<1>>,       :invalid_quoted_string }, # does not start with text byte
        { ~s("string), :invalid_quoted_string }, # missing terminator
      ],

      encode_errors: [
        { :not_a_quoted_string, :invalid_quoted_string },
        { ~s("x),               :invalid_quoted_string }, # only leading quote
        { ~s(x"),               :invalid_quoted_string }, # only trailing quote
      ]
end
