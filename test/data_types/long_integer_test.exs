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
    { "zero length",        <<0>>},
    { "insufficient bytes", <<1>> },
    { "too many bytes",     <<max_short_length() + 1>> },
  ]

  encode_errors [
    { "negative", -1 },
    { "too big",  max_long() + 1 },
  ]
end
