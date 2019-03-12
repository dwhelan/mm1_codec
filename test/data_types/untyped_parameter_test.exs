defmodule MMS.UntypedParameterTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.UntypedParameter,

      examples: [
        {<<"name\0", "value\0">>, {"name", "value"}},
      ],

      decode_errors: [
      ],

      encode_errors: [
      ]
end
