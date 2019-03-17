defmodule MMS.IntegerValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.IntegerValue,

      examples: [
        { << s(0) >>,           0      },
        { << s(127) >>,         127    },
        { << l(1), 128 >>,      128    },
        { << l(2), 255, 255 >>, 65_535 },
      ],

      decode_errors: [
        { <<0>>, {:integer_value, <<0>>, [:long_integer, :must_have_at_least_one_data_byte]} },
      ],

      encode_errors: [
        { -1, {:integer_value, -1, :out_of_range } },
      ]
end

