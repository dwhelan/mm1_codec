defmodule MMS.ExtensionMediaTest do
  use MMS.CodecTest
  import MMS.ExtensionMedia

  codec_examples [
    {"empty string", <<0>>,     ""},
    {"string",       <<"x\0">>, "x"},
  ]

  decode_errors [
    {"invalid extension media", <<"x">>},
  ]

  encode_errors [
    {"invalid extension media", "x\0"},
    {"invalid short integer",   -1},
  ]
end
