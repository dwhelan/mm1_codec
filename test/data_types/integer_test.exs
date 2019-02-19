defmodule MMS.IntegerTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Integer,

      examples: [
        { << s(0) >>,           0      },
        { << s(127) >>,         127    },
        { << l(1), 128 >>,      128    },
        { << l(2), 255, 255 >>, 65_535 },
      ],

      decode_errors: [
        { <<0>>, {:integer, <<0>>, [:long, :must_have_at_least_one_data_byte]} },
      ],

      encode_errors: [
        { -1, {:integer, -1, [:long, :out_of_range] } },
      ]
end

