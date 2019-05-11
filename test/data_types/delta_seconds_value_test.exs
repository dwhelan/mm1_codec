defmodule MMS.DeltaSecondsValueTest do
  use MMS.CodecTest
  import MMS.DeltaSecondsValue

  codec_examples [
    {"0",      << s(0) >>,           0     },
    {"127",    << s(127) >>,         127   },
    {"128",    << l(1), 128 >>,      128   },
    {"65_535", << l(2), 255, 255 >>, 65_535},
  ]

  decode_errors [
    {"Integer-value", <<0>>},
  ]

  encode_errors [
    {"Integer-value", -1},
  ]
end

