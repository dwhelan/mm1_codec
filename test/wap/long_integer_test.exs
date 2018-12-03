defmodule WAP.LongIntegerTest do
  use ExUnit.Case

  thirty_0xffs = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

  use MM1.Codecs.BaseExamples, codec: WAP.LongInteger,
    examples: [
      {<<1,   0>>,           0},
      {<<1, 255>>,         255},
      {<<2,   1,   0>>,    256},
      {<<2, 255, 255>>, 65_535},

      {<<30, thirty_0xffs::240>>, thirty_0xffs}
    ],

    decode_errors: [
      {<< 0>>, :length_must_be_between_1_and_30,  0, << 0>>},
      {<<31>>, :length_must_be_between_1_and_30, 31, <<31>>},
      {<< 1>>, :insufficient_bytes,               1, << 1>>},
    ],

    new_errors: [
      { -1,             :must_be_an_integer_between_1_and_30_bytes_long},
      {thirty_0xffs+1,  :must_be_an_integer_between_1_and_30_bytes_long},
      {:not_an_integer, :must_be_an_integer_between_1_and_30_bytes_long},
    ]
end
