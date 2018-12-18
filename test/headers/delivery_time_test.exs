defmodule MMS.DeliveryTimeTest do
  use ExUnit.Case

  alias MMS.DeliveryTime

  use MMS.TestExamples,
      codec: DeliveryTime,
      examples: [
        {<<3, 128, 1, 0>>, {DateTime.from_unix!(0), 3}},
      ]
end

