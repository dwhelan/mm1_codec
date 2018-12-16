defmodule MMS.DeliveryTimeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.DeliveryTime,
      examples: [
        # short length
        {<<3, 128, 1, 0>>, {0, :absolute, 3}},
        {<<3, 129, 1, 0>>, {0, :relative, 3}},

        # long length
        {<<31, 32, 128, 1, 0>>, {0, :absolute, 32}},
      ],

      decode_errors: [
        {<<32>>,         :first_byte_must_be_less_than_32}, # length error
        {<<3, 0, 1, 0>>, :most_signficant_bit_must_be_1  }, # absolute/relative error
      ]
end

