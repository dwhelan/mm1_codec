defmodule MMS.TextValueTest do
  use MMS.CodecTest
  import MMS.TextValue

  codec_examples [
    {"No-value",      <<0>>,          :no_value},
    {"Token-text",    <<"x\0">>,      "x"},
    {"Quoted-string", << ~s("x\0) >>, ~s("x)},
  ]

  decode_errors [
    {"First byte < 30",       <<1>>},
    {"First byte > 127",      <<128>>},
    {"Invalid Token-text",    <<"x">>},
    {"Invalid Quoted-string", << ~s("x) >>},
  ]

  encode_errors [
    {"First byte < 30",       <<1>>},
    {"First byte > 127",      <<128>>},
    {"Invalid Token-text",    "x\0"},
    {"Invalid Quoted-string", ~s("x\0)},
  ]
end
