defmodule MMS.ShortIntegerTest do
  use MMS.CodecTest
  import MMS.ShortInteger

  codec_examples [
    {"min", <<128>>,   0},
    {"max", <<255>>, 127},
  ]

  decode_errors [
    {"< 128", <<127>>, out_of_range: 127},
  ]

  encode_errors [
    {"bad type", "string", :out_of_range},
  ]
end

