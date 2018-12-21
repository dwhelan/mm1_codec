defmodule MMS.ReplyChargingIdTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReplyChargingId,
      examples: [
        {<<"abc", 0>>, "abc"}
      ]
end
