defmodule MMS.VersionTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Version,

      examples: [
        #     _ '1' indicates short byte
        #      ___ major - 3 bits
        #         ____ minor - 4 bits - all ones means major only
        { <<0b10000000>>, {0, 0}   },
        { "beta 1\0",     "beta 1" },
      ],

      decode_errors: [
        { "no terminator", :invalid_version},
      ],

      encode_errors: [
      ]
end

defmodule MMS.VersionIntegerTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.VersionInteger,

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
        { :not_an_integer_version, :invalid_version_integer },
        { -1,                      :invalid_version_integer },
        {  8,                      :invalid_version_integer },
        { {:x, 0 },                :invalid_version_integer },
        { {-1, 0 },                :invalid_version_integer },
        { {8,  0 },                :invalid_version_integer },
        { {0,  :x},                :invalid_version_integer },
        { {0,  -1},                :invalid_version_integer },
        { {0,  15},                :invalid_version_integer },
      ]
end
