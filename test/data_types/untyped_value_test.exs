defmodule MMS.UntypedValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.UntypedValue,

      examples: [
        { << s(0) >>,  0   },
        { << "a\0" >>, "a" },
      ],

      decode_errors: [
      ],

      encode_errors: [
      ]
end
