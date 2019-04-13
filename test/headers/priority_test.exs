defmodule MMS.PriorityTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Priority,
      examples: [
        { <<128>>, :low    },
        { <<129>>, :normal },
        { <<130>>, :high   },
      ],

      decode_errors: [
        { <<127>>, {:priority, <<127>>, out_of_range: 127}} ,
        { <<131>>, {:priority, <<131>>, out_of_range: 131}} ,
      ]
end

