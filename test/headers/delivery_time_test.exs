defmodule MMS.DeliveryTimeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.DeliveryTime,
      examples: [
        {<<3, 129, 1, 0>>, 0},
      ]
end

