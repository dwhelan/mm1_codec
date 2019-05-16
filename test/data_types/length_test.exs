defmodule MMS.LengthTest do
  use MMS.CodecTest
  import MMS.Length

  codec_examples [
    {"0", <<0>>, 0},
    {"max uintvar integer", max_uintvar_integer_bytes(), max_uintvar_integer()},
  ]

  decode_errors [
    {"128 in first byte", <<128>>},
  ]

  encode_errors [
    {"negative", -1},
  ]
end
