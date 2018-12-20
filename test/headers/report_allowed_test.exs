defmodule MMS.ReportAllowedTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReportAllowed,
      examples: [
        {<<128>>,  true},
        {<<129>>, false},
        {<<130>>,   130},
      ]
end

