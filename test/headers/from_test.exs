defmodule MMS.FromTest do
  use MMS.Test2

  use MMS.TestExamples,
      codec: MMS.From,

      examples: [
        { << l(3), s(0), "@\0" >>, "@"                   }, # email address
        { << l(1), s(1)        >>, :insert_address_token }, # insert address token
      ],

      decode_errors: [
        { << l(0)              >>, :invalid_from }, # length error
        { << l(3), 0,    "@\0" >>, :invalid_from }, # address token error
        { << l(2), s(0), "@"   >>, :invalid_from }, # string missing terminator
        { << l(4), s(1), "@\0" >>, :invalid_from }, # composer error due to invalid length
      ],

      encode_errors: [
        { :not_a_from, :invalid_from },
      ]
end
