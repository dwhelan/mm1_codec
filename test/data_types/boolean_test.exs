defmodule MMS.BooleanTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Boolean,
      examples: [
        { <<128>>,  true },
        { <<129>>, false },
      ],

      decode_errors: [
        { <<127>>, :invalid_boolean },
        { <<130>>, :invalid_boolean },
      ]
end

