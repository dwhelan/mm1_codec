defmodule MMS.VersionIntegerTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.VersionInteger,

      examples: [
        #     _ 1 -> 1 bit
        #      ___ major -> 3 bits
        #         ____ minor -> 4 bits, all ones means major only
        { <<0b10001111>>,  0      },
        { <<0b11111111>>,  7      },
        { <<0b10000000>>, {0,  0} },
        { <<0b10001110>>, {0, 14} },
      ],

      decode_errors: [
        { <<0>>,   {:version_integer, <<0>>,   out_of_range: 0}}   ,
        { <<127>>, {:version_integer, <<127>>, out_of_range: 127}} ,
      ],

      encode_errors: [
        { -1,       {:version_integer, -1,       :out_of_range}       },
        {  8,       {:version_integer, 8,        :out_of_range}       },
        { {-1, 0 }, {:version_integer, {-1, 0},  :major_out_of_range} },
        { {8,  0 }, {:version_integer, {8,  0},  :major_out_of_range} },
        { {0,  -1}, {:version_integer, {0,  -1}, :minor_out_of_range} },
        { {0,  15}, {:version_integer, {0,  15}, :minor_out_of_range} },
      ]
end
