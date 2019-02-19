defmodule MMS.BooleanTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Boolean,

      examples: [
        { << s(0) >>, true  },
        { << s(1) >>, false },
      ],

      decode_errors: [
        { << 127 >>, {:invalid_boolean, <<127>>, %{out_of_range: 127}} },
        { << 130 >>, {:invalid_boolean, <<130>>, %{out_of_range: 130}} },
      ]
end

