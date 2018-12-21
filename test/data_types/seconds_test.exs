defmodule MMS.SecondsTest do
  use ExUnit.Case
  import MMS.DataTypes

  alias MMS.Seconds

  length_quote = 31

  use MMS.TestExamples,
      codec: Seconds,
      examples: [
        {<<3, 128, 1, 0>>, DateTime.from_unix!(0)}, # short length, absolute
        {<<3, 129, 1, 0>>, 0                     }, # short length, relative

        {<<length_quote, 32, 129>> <> max_long_bytes(), max_long()}, # uint32 length, relative
        # Note: cannot test an absolute max_long converted to a DateTime because it is too large for DateTime.from_unix
      ],

      decode_errors: [
        {<<32>>,            :first_byte_must_be_less_than_32},        # length error
        {<<3,   0,  1, 0>>, :absolute_value_must_be_128_to_129}, # absolute/relative error
        {<<3, 128, 31, 0>>, :invalid_long_length}, # value error
      ],

      encode_errors: [
        {-1,             :invalid_long},
        {max_long() + 1, :invalid_long},
      ]
end
