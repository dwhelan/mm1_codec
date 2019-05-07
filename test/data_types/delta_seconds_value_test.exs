defmodule MMS.DeltaSecondsValueTest do
  use MMS.CodecTest
  import MMS.DeltaSecondsValue

  codec_examples [
    { "a", << s(0) >>,           0      },
    { "b", << s(127) >>,         127    },
    { "c", << l(1), 128 >>,      128    },
    { "d", << l(2), 255, 255 >>, 65_535 },
  ]

  decode_errors [
    { "x", <<0>>, [:integer_value, {:short_integer, [out_of_range: 0]}, {:long_integer, :must_have_at_least_one_data_byte}] },
  ]

  encode_errors [
    { "x", -1, {:integer_value, -1, [short_integer: :out_of_range, long_integer: :out_of_range] } },
  ]
end

