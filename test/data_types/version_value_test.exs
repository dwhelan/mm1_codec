defmodule MMS.VersionValueTest do
  use MMS.CodecTest
  import MMS.VersionValue

  codec_examples [
    {"Version-integer 0.0", <<0b10000000>>, {0, 0}},
    {"Version-integer 7",   <<0b11111111>>, 7},
    {"Text-string",         "beta 1\0",     "beta 1"},
  ]

  decode_errors [
    {"Text-string", "no end of string"},
    {"Neither Version-integer or Text-string", <<0>>},
  ]

  encode_errors [
    {"Version-integer", 8},
    {"Text-string", "has end of string\0"},
  ]
end
