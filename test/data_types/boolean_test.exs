defmodule MMS.BooleanTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Boolean,
      examples: [
        {<<128>>,  true},
        {<<129>>, false},
        {<<130>>,   130},
      ]
end

