defmodule MMS.DeliveryTimeTest do
  use ExUnit.Case

  alias MMS.DeliveryTime

  use MMS.TestExamples,
      codec: DeliveryTime,
      examples: [
        {<<3, 128, 1, 0>>, {0, :absolute, 3}},
      ]
end

