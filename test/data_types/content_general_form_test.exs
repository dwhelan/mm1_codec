defmodule MMS.ContentGeneralFormTest do
  use MMS.CodecTest
  import MMS.ContentGeneralForm

  codec_examples [
    {"valid length and media", <<l(1), s(0)>>, :"*/*"},
  ]

  decode_errors [
    {"invalid length", <<l(255)>>},
    {"invalid media",  <<l(1), "invalid media">>},
  ]

  encode_errors [
    {"invalid media", :"invalid media"},
  ]
end
