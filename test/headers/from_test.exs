defmodule MMS.FromTest do
  use MMS.CodecTest

  import MMS.From

  codec_examples [
    {"address present token", <<l(3), 128, "@\0">>, {"@", ""}},
    {"insert address token",  <<l(1), 129>>,        :insert_address_token},
  ]

  decode_errors [
    {"zero length",   <<l(0)>>, address: :no_bytes},
    {"invalid token", <<l(3), 0, "@\0" >>, address: :out_of_range },
    {"address error", <<l(2), 128, "@" >>, address:  [:address, :text, :missing_end_of_string] },
    {"invalid length",  <<l(4), 128, "@\0" >>, value_length: [
                short_length: [required_bytes: 4, available_bytes: 3],
                quoted_length: :does_not_start_with_a_length_quote
              ]},
  ]

  encode_errors [
  ]

end
