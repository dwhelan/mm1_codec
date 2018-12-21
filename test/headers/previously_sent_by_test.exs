defmodule MMS.PreviouslySentByTest do
  use ExUnit.Case
  import MMS.DataTypes

  alias MMS.PreviouslySentBy

  length_quote = 31

  use MMS.TestExamples,
      codec: PreviouslySentBy,
      examples: [
        {<<3, 129, "@", 0        >>, {  1, "@"}}, # short count
        {<<5,   2,   1, 0, "@", 0>>, {256, "@"}}, # long count
      ],

      decode_errors: [
#        {<<32>>,            :first_byte_must_be_less_than_32},        # length error
#        {<<3,   0,  1, 0>>, :absolute_value_must_be_128_to_129}, # absolute/relative error
#        {<<3, 128, 31, 0>>, :length_must_be_between_1_and_30}, # value error
      ],

      encode_errors: [
#        {-1,             :must_be_an_unsigned_integer_between_1_and_30_bytes_long},
#        {max_long() + 1, :must_be_an_unsigned_integer_between_1_and_30_bytes_long},
      ]
end
