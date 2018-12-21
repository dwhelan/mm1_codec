defmodule MMS.FromTest do
  use ExUnit.Case

  alias MMS.From

  use MMS.TestExamples,
      codec: From,
      examples: [
        {<<5, 128, "x@y", 0>>, "x@y"                }, # email address
        {<<1, 129          >>, :insert_address_token}, # insert address token
      ],

      decode_errors: [
        {<<0               >>, :invalid_length       }, # length error
        {<<5,   0, "x@y", 0>>, :invalid_address_token}, # address token error
        {<<4, 128, "x@y"   >>, :missing_terminator   }, # string error
        {<<6, 128, "x@y", 0>>, :incorrect_length     }, # composer error
      ],

      encode_errors: [
      ]
end
