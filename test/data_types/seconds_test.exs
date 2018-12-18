defmodule MMS.SecondsTest do
  use ExUnit.Case

  alias MMS.Seconds

  time_zero    = DateTime.from_unix!(0)
  length_quote = 31

  thirty_0xffs = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

  use MMS.TestExamples,
      codec: Seconds,
      examples: [
        {<<3, 128, 1, 0>>, time_zero}, # short length, absolute
        {<<3, 129, 1, 0>>, 0        }, # short length, relative

        {<<length_quote, 32, 129, 30, thirty_0xffs::240>>, thirty_0xffs}, # uint32 length, absolute
      ],

      decode_errors: [
        {<<32>>,            :first_byte_must_be_less_than_32}, # length error
#        {<<3,   0,  1, 0>>, :most_signficant_bit_must_be_1  }, # absolute/relative error
        {<<3, 128, 31, 0>>, :length_must_be_between_1_and_30}, # value error
      ],

      encode_errors: [
#        {-1, :must_be_an_unsigned_32_bit_integer            }, # length error
      ]
end

