defmodule MMS.TextValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.TextValue,

      examples: [
        { <<0>>,   :no_value },
        { "x\0",   "x"       },
        { "\"x\0", ~s("x")   },
      ],

      decode_errors: [
        {<<128>>, :invalid_text_value },
      ],

      encode_errors: [
      ]
end
