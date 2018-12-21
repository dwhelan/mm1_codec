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
      {<< 0>>, :invalid_long_length},
      {<<31>>, :invalid_long_length},
      {<< 1>>, :insufficient_bytes },
    ],

    encode_errors: [
      {-1,              :invalid_long},
      {max_long()+1,    :invalid_long},
      {:not_an_integer, :invalid_long},
    ]
end
