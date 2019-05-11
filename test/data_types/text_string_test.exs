defmodule MMS.TextStringTest do
  use MMS.CodecTest
  import MMS.TextString

  @quote 127

  codec_examples [
    {"unquoted", "x\0",                  "x"},
    {"quoted",   <<@quote, 128, "x\0">>, <<128, "x">>},
  ]

  decode_errors [
    {"must start with a char", <<"\0">>},
    {"unecessary quote", <<@quote, 127, "x\0">>, :unnecessary_quote},
    {"missing end of string", <<"string">>},
    {"invalid first byte", <<1>>, :first_byte_must_be_a_char_or_quote                 },
  ]

  encode_errors [
    {"text", "x\0"}
  ]
end
