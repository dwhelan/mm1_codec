defmodule MMS.LongTest do
  use ExUnit.Case
  import MMS.DataTypes

  use MMS.TestExamples, codec: MMS.Long,
    examples: [
      {<<1,   0>>,           0},
      {<<1, 255>>,         255},
      {<<2,   1,   0>>,    256},
      {<<2, 255, 255>>, 65_535},

      {max_long_bytes(), max_long()}
    ],

    decode_errors: [
      {<< 0>>, {:length_must_be_between_1_and_30,  0}},
      {<<31>>, {:length_must_be_between_1_and_30, 31}},
      {<< 1>>, :insufficient_bytes                   },
    ],

    encode_errors: [
      {-1,              :must_be_an_integer_between_1_and_30_bytes_long},
      {max_long()+1,    :must_be_an_integer_between_1_and_30_bytes_long},
      {:not_an_integer, :must_be_an_integer_between_1_and_30_bytes_long},
    ]
end
