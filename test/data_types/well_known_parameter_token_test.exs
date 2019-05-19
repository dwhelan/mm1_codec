defmodule MMS.WellKnownParameterTokenTest do
  use MMS.CodecTest
  import MMS.WellKnownParameterToken

  codec_examples [
    {"0", << s(0) >>, 0},
  ]

  decode_errors [
    {"bad integer", <<0>>},
  ]

  encode_errors [
    {"negative integer", -1},
  ]
end
