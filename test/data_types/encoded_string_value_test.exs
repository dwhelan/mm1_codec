defmodule MMS.EncodedStringValueTest do
  use MMS.CodecTest

  alias MMS.EncodedStringValue

  use MMS.TestExamples,
      codec: EncodedStringValue,

      examples: [
        { << l(3), s(106), "x\0" >>, {"x", :csUTF8} },
      ],

      decode_errors: [
      ]
end

