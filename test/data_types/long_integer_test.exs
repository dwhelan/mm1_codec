defmodule MMS.LongIntegerTest do
  use MMS.CodecTest
  import MMS.LongInteger

  codec_examples [
    { "0",      << l(1), 0 >>,        0          },
    { "255",    << l(1), 255 >>,      255        },
    { "256",    << l(2), 1,   0 >>,   256        },
    { "65,535", << l(2), 255, 255 >>, 65_535     },
    { "max",    max_long_bytes(),     max_long() },
  ]

  decode_errors [
    { "zero length",        <<0>>,                      {:long_integer, <<0>>,                      :must_have_at_least_one_data_byte}},
    { "insufficient bytes", <<1>>,                      {:long_integer, <<1>>,                      [:short_length, required_bytes: 1, available_bytes: 0]} },
    { "too many bytes",     <<max_short_length() + 1>>, {:long_integer, <<max_short_length() + 1>>, [:short_length, out_of_range: max_short_length()+1]} },
  ]

  encode_errors [
    { "negative", -1,           {:long_integer, -1,           :out_of_range} },
    { "too big",  max_long()+1, {:long_integer, max_long()+1, :out_of_range} },
  ]
end
