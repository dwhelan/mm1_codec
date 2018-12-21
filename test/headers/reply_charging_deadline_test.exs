defmodule MMS.ReplyChargingDeadlineTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReplyChargingDeadline,
      examples: [
        {<<3, 129, 1, 0>>, 0},
      ]
end

