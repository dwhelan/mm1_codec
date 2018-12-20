defmodule MMS.SenderVisibilityTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.SenderVisibility,
      examples: [
        {<<128>>, :hide},
        {<<129>>, :show},
        {<<130>>,   130},
      ]
end

