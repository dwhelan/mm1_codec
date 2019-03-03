defmodule MMS.ReadStatusTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReadStatus,

      examples: [
        { <<128>>, :read    },
        { <<129>>, :deleted_without_being_read },
      ],

      decode_errors: [
        { <<127>>, {:read_status, <<127>>, %{out_of_range: 127}} },
        { <<130>>, {:read_status, <<130>>, %{out_of_range: 130}} },
      ]
end

