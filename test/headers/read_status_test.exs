defmodule MMS.ReadStatusTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReadStatus,

      examples: [
        { <<128>>, :read    },
        { <<129>>, :deleted },
      ],

      decode_errors: [
        { <<127>>, :invalid_read_status },
        { <<130>>, :invalid_read_status },
      ]
end

