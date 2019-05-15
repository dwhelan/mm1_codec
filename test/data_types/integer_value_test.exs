defmodule MMS.IntegerValueTest do
  use MMS.CodecTest
  import MMS.IntegerValue

  codec_examples [
    {"0",      << s(0) >>,           0},
    {"127",    << s(127) >>,         127},
    {"128",    << l(1), 128 >>,      128},
    {"65,535", << l(2), 255, 255 >>, 65_535},
  ]

  decode_errors [
    {"bad integer", <<0>>, short_integer: [out_of_range: 0], long_integer: :must_have_at_least_one_data_byte},
  ]

  encode_errors [
    {"negative integer", -1, short_integer: :out_of_range, long_integer: :out_of_range},
  ]
end

