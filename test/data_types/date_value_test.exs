defmodule MMS.DateValueTest do
  use MMS.CodecTest
  import MMS.DateValue

  codec_examples [
    { "time zero",     << l(1), 0>>,   DateTime.from_unix! 0   },
    { "non-zero time", << l(1), 127>>, DateTime.from_unix! 127 },
  ]

  decode_errors [
    {"bad long integer", <<0>>},
  ]

  encode_errors [
    {"too small", -1},
    {"too large", max_long},
  ]
end
