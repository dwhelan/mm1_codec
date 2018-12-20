defmodule MMS.DeliveryReportTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.DeliveryReport,
      examples: [
        {<<128>>, :yes},
        {<<129>>,  :no},
        {<<130>>,  130},
      ]
end

