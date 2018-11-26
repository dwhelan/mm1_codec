defmodule WAP.LongIntegerTest do
  use ExUnit.Case

  use MM1.CodecExamples, module: WAP.LongInteger,
    examples: [
      {<<1,   0>>,           0},
      {<<1, 255>>,         255},
      {<<2,   1,   0>>,    256},
      {<<2, 255, 255>>, 65_535},
      {
        <<30, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff::240>>,
        0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
      }
    ],
    decode_errors: [
      {<<31>>, :length_cannot_be_greater_than_30, 31},
    ]
end
