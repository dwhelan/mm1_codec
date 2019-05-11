defmodule MMS.EncodedStringValueTest do
  use MMS.CodecTest

  import MMS.EncodedStringValue

  string30 = String.duplicate "x", 30

  codec_examples [
    {"text string",              <<"x\0">>,                 "x" },
    {"text string with charset", << l(3), s(106), "x\0" >>, {"x", :UTF8}},
  ]

  decode_errors [
    {"text string",              <<"\0">>},
    {"value length",             <<l(2)>>},
    {"text string with charset", <<l(2), s(106), "x">>},
    {"charset",                  <<l(3), s(127), "x\0">>},
  ]

  encode_errors [
    {"text string",              "x\0"},
    {"test string with charset", {"x\0", :UTF8}},
    {"charset",                  {"x", :bad_charset}},
  ]
end

