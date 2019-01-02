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
        {<<32>>,            :invalid_length                 }, # length error
        {<<3,   0,  1, 0>>, :invalid_absolute_relative_token}, # absolute/relative token error
        {<<3, 128,  0, 0>>, :invalid_long                   }, # value error
      ],

      encode_errors: [
        {-1,             :invalid_long},
        {max_long() + 1, :invalid_long},
      ]
end
