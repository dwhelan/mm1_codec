defmodule MMS.ConstrainedMediaTest do
  use MMS.CodecTest
  import MMS.ConstrainedMedia

  codec_examples [
    {"empty string", <<0>>,          ""},
    {"space",        <<" \0">>,      " "},
    {"largest char", <<0x7f, 0>>,    <<0x7f>>},
    {"string\0",     <<"string\0">>, "string"},

    {"min short integer", <<s(0)>>,   0},
    {"max short integer", <<s(127)>>, 127},
  ]

  decode_errors [
    {"invalid extension media", <<"x">>},
    {"invalid short integer ",  <<127>>},
  ]

  encode_errors [
    {"invalid extension media", "x\0"},
    {"invalid short integer",   -1},
  ]
end
