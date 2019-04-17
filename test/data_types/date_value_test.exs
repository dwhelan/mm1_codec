defmodule MMS.DateValueTest do
  use MMS.CodecTest
  import MMS.DateValue

  codec_examples [
    { "time zero",     << l(1), 0>>,   DateTime.from_unix! 0   },
    { "non-zero time", << l(1), 127>>, DateTime.from_unix! 127 },
  ]

  decode_errors [
    {"bad long integer", <<0>>, [:long_integer]},
  ]

  encode_errors [
    {"bad type", "string", :out_of_range},
  ]
end
