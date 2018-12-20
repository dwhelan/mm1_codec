defmodule MMS.ReadReportTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReadReport,
      examples: [
        {<<128>>,  true},
        {<<129>>, false},
        {<<130>>,   130},
      ]
end

