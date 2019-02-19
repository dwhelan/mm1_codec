defmodule MMS.ByteTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Byte,

      examples: [
        { << 0 >>,   0   },
        { << 255 >>, 255 },
      ],

      encode_errors: [
        { -1,  {:invalid_byte, -1,  :out_of_range} },
        { 256, {:invalid_byte, 256, :out_of_range} },
      ]
end
