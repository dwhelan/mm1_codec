defmodule MMS.ReplyChargingSizeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReplyChargingSize,
      examples: [
        {<<1, 42>>, 42}
      ]
end
