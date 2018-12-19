defmodule MMS.FromTest do
  use ExUnit.Case

  alias MMS.From

  use MMS.TestExamples,
      codec: From,
      examples: [
        {<<5, 128, "x@y", 0>>, "x@y"                }, # email address
        {<<1, 129>>,           :insert_address_token}, # insert address token
      ],

      decode_errors: [
        {<<32>>,            :first_byte_must_be_less_than_32 }, # length error
#        {<<6, 128, "x@y", 0>>, :invalid_length                }, # email address
        {<<3,   0,  1, 0>>, :address_token_must_be_128_to_129}, # address token error
        {<<4, 128, "x@y">>, :missing_terminator              }, # string error
      ],

      encode_errors: [
      ]
end
