defmodule MMS.FromTest do
  use ExUnit.Case

  alias MMS.From

  use MMS.TestExamples,
      codec: From,
      examples: [
#        {<<3, 128, "x", 0>>, {"x", 3}},
      ]
#
#      decode_errors: [
#        {<<32>>,            :first_byte_must_be_less_than_32}, # length error
#        {<<3,   0,  1, 0>>, :most_signficant_bit_must_be_1  }, # absolute/relative error
#        {<<3, 128, 31, 0>>, :length_must_be_between_1_and_30}, # value error
#      ],
#
#      encode_errors: [
#        {{0, -1}, :must_be_an_unsigned_32_bit_integer            }, # length error
#      ]
end

