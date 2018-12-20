defmodule MMS.ReadStatusTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReadStatus,
      examples: [
        {<<128>>,    :read},
        {<<129>>, :deleted},
        {<<130>>,      130},
      ]
end

