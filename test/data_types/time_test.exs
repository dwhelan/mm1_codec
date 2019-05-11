defmodule MMS.TimeTest do
  use MMS.CodecTest
  import MMS.Time

  abs = s(0)
  rel = s(1)

  codec_examples [
    {"Absolute-token Date-value",          << l(3), abs, l(1), 0 >>, date_time(0)},
    {"Relative-token Delta-seconds-value", << l(3), rel, l(1), 0 >>, 0},
  ]

  decode_errors [
    {"Value-length",        << l(32) >>},
    {"Token",               << l(1), 0>>},
    {"Date-value",          << l(3), abs, 0 >>},
    {"Delta-seconds-value", << l(3), rel, 0 >>},
  ]

  encode_errors [
    {"Date-value",          date_time(-1)},
    {"Delta-seconds-value", -1},
  ]
end
