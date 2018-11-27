defmodule WAP.LongIntegerTest do
  use ExUnit.Case

  max_value = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

  use MM1.CodecExamples, codec: WAP.LongInteger,
    examples: [
      {<<1,   0>>,           0},
      {<<1, 255>>,         255},
      {<<2,   1,   0>>,    256},
      {<<2, 255, 255>>, 65_535},

      {<<30, max_value::240>>, max_value}
    ],

    decode_errors: [
      {<< 0>>, :length_must_be_between_1_and_30,  0},
      {<< 1>>, :insufficient_bytes,               1},
      {<<31>>, :length_must_be_between_1_and_30, 31},
    ],

    new_errors: [
      {  -1,        :must_be_an_integer_between_1_and_30_bytes_long},
      {1.23,        :must_be_an_integer_between_1_and_30_bytes_long},
      { "x",        :must_be_an_integer_between_1_and_30_bytes_long},
      {:foo,        :must_be_an_integer_between_1_and_30_bytes_long},
      {max_value+1, :must_be_an_integer_between_1_and_30_bytes_long},
    ]
end
