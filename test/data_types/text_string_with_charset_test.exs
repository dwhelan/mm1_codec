defmodule MMS.TextStringWithCharsetTest do
  use MMS.CodecTest

  alias MMS.TextStringWithCharset

  use MMS.TestExamples,
      codec: TextStringWithCharset,

      examples: [
        { << l(3), s(106), "x\0" >>, {"x", :csUTF8}},
      ],

      decode_errors: [
      ]
end

