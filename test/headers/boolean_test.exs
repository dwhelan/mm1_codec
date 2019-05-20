defmodule MMS.BooleanTest do
  use MMS.CodecTest
  import MMS.Boolean

  codec_examples [
    {"true",  <<128>>, true},
    {"false", <<129>>, false},
  ]

  decode_errors [
    {"other", <<127>>},
  ]

  encode_errors [
    {"other", :not_boolean},
  ]
end

