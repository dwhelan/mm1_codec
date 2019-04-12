defmodule MMS.DeltaSecondsValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.DeltaSecondsValue,

      examples: [
        { << s(0) >>,           0      },
        { << s(127) >>,         127    },
        { << l(1), 128 >>,      128    },
        { << l(2), 255, 255 >>, 65_535 },
      ],

      decode_errors: [
        { <<0>>, {:integer_value, <<0>>, [{:short_integer, [out_of_range: 0]}, {:long_integer, :must_have_at_least_one_data_byte}]} },
      ],

      encode_errors: [
        { -1, {:integer_value, -1, [short_integer: :out_of_range, long_integer: :out_of_range] } },
      ]
end

