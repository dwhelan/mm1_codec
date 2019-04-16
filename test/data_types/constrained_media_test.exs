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
    {"invalid extension media", <<"x">>, [:constrained_encoding, {:extension_media, [:text, :missing_end_of_string]}, {:short_integer, [out_of_range: 120]}]},
    {"invalid short integer ",  <<127>>, [:constrained_encoding, {:extension_media, [:text, :missing_end_of_string]}, {:short_integer, [out_of_range: 127]}]},
  ]

  encode_errors [
    {"invalid extension media", "x\0", [:constrained_encoding, {:extension_media, [:text, :contains_end_of_string]}, {:short_integer, :out_of_range}]},
    {"invalid short integer",   -1,    [:constrained_encoding, {:extension_media, [:text, :invalid_type]},           {:short_integer, :out_of_range}]},
  ]end
