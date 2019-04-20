defmodule MMS.LengthTest do
  use MMS.CodecTest
  import MMS.Length

  codec_examples [
    {"0", <<0>>, 0},
  ]

  decode_errors [
    {"128 as first byte", <<128>>},
  ]

  encode_errors [
    {"negative length", -1},
  ]

end
