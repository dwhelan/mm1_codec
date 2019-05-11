defmodule MMS.FromTest do
  use MMS.CodecTest

  import MMS.From

  codec_examples [
    {"address present token", <<l(3), 128, "@\0">>, {"@", ""}},
    {"insert address token",  <<l(1), 129>>,        :insert_address_token},
  ]

  decode_errors [
    {"zero length",    <<l(0)>>},
    {"invalid token",  <<l(3)>>},
    {"address error",  <<l(2)>>},
    {"invalid length", <<l(4), 128, "@\0">>},
  ]

  encode_errors [
  ]

end
