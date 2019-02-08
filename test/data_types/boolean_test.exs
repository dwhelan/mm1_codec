defmodule MMS.BooleanTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Boolean,

      examples: [
        { << s(0) >>, true  },
        { << s(1) >>, false },
      ],

      decode_errors: [
        { <<0>>,    {:invalid_boolean, <<0>>, :out_of_range} },
        { <<s(2)>>, {:invalid_boolean, <<130>>, :out_of_range} },
      ],

      encode_errors: [
      ]
end

