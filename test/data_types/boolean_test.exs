defmodule MMS.BooleanTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Boolean,

      examples: [
        { << s(0) >>, true  },
        { << s(1) >>, false },
      ],

      decode_errors: [
        { <<0>>,    {:invalid_boolean, <<0>>, :not_found} },
        { <<s(2)>>, {:invalid_boolean, <<130>>, :not_found} },
      ],

      encode_errors: [
      ]
end

