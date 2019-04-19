defmodule MMS.FieldNameTest do
  use MMS.CodecTest
  import MMS.FieldName

  codec_examples [
    { "well known field name", << s(0) >>, 0},
    { "token text",            << "a\0" >>, "a"},
  ]

  decode_errors [
    {"bad token text", <<0>>},
  ]

  encode_errors [
  ]
end

