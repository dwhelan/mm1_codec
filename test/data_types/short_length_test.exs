defmodule MMS.ShortLengthTest do
  use MMS.CodecTest
  import MMS.ShortLength

  @thirty_chars String.duplicate("a", 30)

  codec_examples [
    {"min length", {<<0>>,  <<>>},          0},
    {"max length", {<<30>>, @thirty_chars}, 30},
  ]

  decode_errors [
    { "insufficient bytes",   <<5, "rest">>, required_bytes: 5, available_bytes: 4},
    { "invalid short length", <<31>>,        out_of_range: 31},
  ]

  encode_errors [
    { "invalid short length", 31, :out_of_range},
  ]
end
