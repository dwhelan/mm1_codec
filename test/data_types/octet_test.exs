defmodule MMS.OctetTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Octet,

      examples: [
        { << 0 >>,   0   },
        { << 255 >>, 255 },
      ],

      encode_errors: [
        { -1,  {:octet, -1,  :out_of_range} },
        { 256, {:octet, 256, :out_of_range} },
      ]
end
