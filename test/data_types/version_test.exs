defmodule MMS.VersionTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Version,

      examples: [
        { <<0b10000000>>, {0, 0}   },
        { <<0b11111111>>, 7   },
        { "beta 1\0",     "beta 1" },
      ],

      decode_errors: [
        { "no end of string", {:version, "no end of string", [:text, :missing_end_of_string]}},
      ],

      encode_errors: [
      ]
end
