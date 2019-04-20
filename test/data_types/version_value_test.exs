defmodule MMS.VersionValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.VersionValue,

      examples: [
        { <<0b10000000>>, {0, 0}   },
        { <<0b11111111>>, 7   },
        { "beta 1\0",     "beta 1" },
      ],

      decode_errors: [
        { "no end of string", {:version_value, "no end of string", [{:version_integer, [out_of_range: 110]}, {:text_string, [:text, :missing_end_of_string]}]}},
      ],

      encode_errors: [
      ]
end
