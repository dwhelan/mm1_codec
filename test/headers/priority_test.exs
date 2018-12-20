defmodule MMS.PriorityTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Priority,
      examples: [
        {<<128>>, :low   },
        {<<129>>, :normal},
        {<<130>>, :high  },
        {<<131>>, 131    },
      ]
end

