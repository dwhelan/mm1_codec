defmodule MMS.IntegerVersionTest do
  use MMS.Test

  use MMS.TestExamples,
      codec: MMS.IntegerVersion,

      examples: [
        #      ___ major - 3 bits
        #         ____ minor - 4 bits - all ones means major only
        { <<0b10000000>>, {0,  0} },
        { <<0b10000001>>, {0,  1} },
        { <<0b10001110>>, {0, 14} },
        { <<0b10001111>>,  0      },
        { <<0b11111111>>,  7      },
      ],

      encode_errors: [
        { :not_an_integer_version, :invalid_integer_version },
        { -1,                      :invalid_integer_version },
        {  8,                      :invalid_integer_version },
        { {:x, 0 },                :invalid_integer_version },
        { {-1, 0 },                :invalid_integer_version },
        { {8,  0 },                :invalid_integer_version },
        { {0,  :x},                :invalid_integer_version },
        { {0,  -1},                :invalid_integer_version },
        { {0,  15},                :invalid_integer_version },
      ]
end

