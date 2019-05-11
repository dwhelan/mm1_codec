defmodule MMS.QuotedStringTest do
  use MMS.CodecTest

  import MMS.QuotedString

  codec_examples [
    {"quoted text", ~s("x\0), ~s("x) },
  ]

  decode_errors [
    {"missing quote", <<1>>},
    {"text",          ~s("string)},
  ]

  encode_errors [
    {"1", "x"},
    {"2", ~s("x\0")},
  ]
end
