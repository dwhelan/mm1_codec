defmodule MMS.OctetTest do
  use MMS.CodecTest
  import MMS.Octet

  codec_examples [
    {"min", <<0>>, 0},
    {"max", <<255>>, 255},
  ]

  encode_errors [
    {"too small", -1, :out_of_range},
    {"too large", 256, :out_of_range},
    {"bad value", :bad_type, :out_of_range},
  ]
end
