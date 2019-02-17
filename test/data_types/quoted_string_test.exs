defmodule MMS.QuotedStringTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.QuotedString,

      examples: [
        { ~s("\0),  ~s(")  },
        { ~s("x\0), ~s("x) },
      ],

      decode_errors: [
        { <<1>>,       {:invalid_quoted_string, <<1>>,       :must_start_with_a_quote}         },
        { ~s("string), {:invalid_quoted_string, ~s("string), :missing_end_of_string_0_byte} },
      ],

      encode_errors: [
        { "x",       {:invalid_quoted_string, "x",       :must_start_with_a_quote}         },
        { ~s("x\0"), {:invalid_quoted_string, ~s("x\0"), :contains_end_of_string_0} },
      ]
end
