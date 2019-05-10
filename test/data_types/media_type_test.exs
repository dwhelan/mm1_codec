defmodule MMS.MediaTypeTest do
  use MMS.CodecTest
  import MMS.MediaType

  codec_examples [
    {"well known media",             <<s(0)>>,            :"*/*"},
    {"extension media: other/other", <<"other/other\0">>, "other/other"},
  ]

  decode_errors [
    {"invalid well known media", <<s(127)>> },
    {"invalid extension media",  <<"missing end of string">> },
  ]

  encode_errors [
    {"invalid well known media", :"invalid media" },
    {"invalid extension media",  "contains end of string\0"},
  ]
end
