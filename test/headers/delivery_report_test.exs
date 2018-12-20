defmodule MMS.DeliveryReportTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.DeliveryReport,
      examples: [
        {<<128>>,  true},
        {<<129>>, false},
        {<<130>>,   130},
      ]
end

