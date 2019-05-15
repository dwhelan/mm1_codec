defmodule MMS.ContentGeneralFormTest do
  use MMS.CodecTest
  import MMS.ContentGeneralForm

  codec_examples [
    {"media with a single parameter", <<l(1), s(0)>>, :"*/*"},
    {"media with two parameters", <<l(1), s(0x33)>>, :"application/vnd.wap.multipart.related"},
  ]

  decode_errors [
    {"invalid length", <<l(255)>>},
    {"invalid media",  <<l(13), "invalid media">>},
  ]

  encode_errors [
    {"invalid media", :"invalid media"},
  ]
end
