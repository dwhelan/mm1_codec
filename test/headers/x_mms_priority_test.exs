defmodule MMS.XMmsPriorityTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.XMmsPriority,
      examples: [
        {<<128>>, :low   },
        {<<129>>, :normal},
        {<<130>>, :high  },
        {<<131>>, 3      },
      ]
end

