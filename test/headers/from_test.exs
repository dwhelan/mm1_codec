defmodule MMS.FromTest do
  use ExUnit.Case

  alias MMS.From

  use MMS.TestExamples,
      codec: From,
      examples: [
        {<<3, 128, "x", 0>>, "x"                  }, # address present token
        {<<1, 129>>,         :insert_address_token}, # insert address token
      ],

      decode_errors: [
        {<<32>>,            :first_byte_must_be_less_than_32      }, # length error
        {<<3,   0,  1, 0>>, {:address_token_must_be_128_to_129, 0}}, # address token error
        {<<3, 128, "x">>,   :missing_terminator                   }, # string error
      ],

      encode_errors: [
      ]
end

# Addressing
#   phone: string ["+"] 1*( DIGIT / written-sep ) written-sep =("-"/".")
#   email: string not any of the others? or simple has a '@' https://gist.github.com/mgamini/4f3a8bc55bdcc96be2c6
#   ipv4 : string (to charset) or charset parseable via inet:parse_address/1
#   ipv6 : string (to charset) or charset parseable via inet:parse_address/1
