defmodule MMS.UntypedParameterTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.UntypedParameter,

      examples: [
        {<<"name\0", "value\0">>, {"name", "value"}},
        {<<"name\0", s(0)>>,      {"name", 0      }},
      ],

      decode_errors: [
      ],

      encode_errors: [
      ]
end
