defmodule MMS.FromTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.From,

      examples: [
        { << l(3), s(0), "@\0" >>, {"@", ""}         },
        { << l(1), s(1)        >>, :insert_address_token },
      ],

      decode_errors: [
        { << l(0)              >>, :from }, # length error
        { << l(3), 0,    "@\0" >>, :from }, # address token error
        { << l(2), s(0), "@"   >>, :from }, # string missing terminator
        { << l(4), s(1), "@\0" >>, :from }, # composer error due to invalid length
      ],

      encode_errors: [
      ]
end
