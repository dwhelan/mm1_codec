defmodule MMS.SubjectTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Subject,
      examples: [
        {<<"x",    0        >>, "x"           },
        {<< 3,  0xea, "x", 0>>, {:csUTF8, "x"}},
      ],

      decode_errors: [
        {<<"x">>,          :missing_terminator},
        {<<2, 0xea, "x">>, :missing_terminator},
      ]
end
