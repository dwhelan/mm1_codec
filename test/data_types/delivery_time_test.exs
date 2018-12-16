defmodule MMS.DeliveryTimeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.DeliveryTime,
      examples: [
        {<<3, 128, 1, 0>>, {0, :absolute, 3}},
      ],

      decode_errors: [
#        {<<"string">>,          :missing_terminator},
#        {<<6, 0xea, "string">>, :missing_terminator},
      ]
end

