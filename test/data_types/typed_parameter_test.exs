defmodule MMS.TypedParameterTest do
  use MMS.CodecTest
  import MMS.TypedParameter

  codec_examples [
    {"Q-value", << s(0),  1     >>, {:q, "00"} },
    {"Path",    << s(29), "a\0" >>, {:path, "a"} },
  ]

  decode_errors [
    {"Well-known-parameter-token", << s 30 >>},
    {"Typed-value",                << s(8), 1 >>},
  ]

  encode_errors [
    {"Well-known-parameter-token",  {:bad_token, 0}},
    {"Typed-value",                 {:q, :bad_value}},
  ]
end
