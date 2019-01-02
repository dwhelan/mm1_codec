defmodule MMS.Uint32Test do
  use ExUnit.Case
  import MMS.DataTypes

  use MMS.TestExamples,
      codec: MMS.Uint32,
      examples: [
        { <<0>>, 0 },
        { <<127>>, 127 },
        { <<129, 0>>, 128 },
        { <<255, 127>>, 16_383 },
        { <<129, 128, 0>>, 16_384 },
        { <<255, 255, 127>>, 2_097_151 },
        { <<129, 128, 128, 0>>, 2_097_152 },
        { <<255, 255, 255, 127>>, 268_435_455 },
        { <<129, 128, 128, 128, 0>>, 268_435_456 },
        { <<143, 255, 255, 255, 127>>, max_uint32() },
      ],

      decode_errors: [
        { <<128>>,                          :invalid_uint32 },
        { <<129, 255, 255, 255, 255, 127>>, :invalid_uint32 },
      ],

      encode_errors: [
        { -1,               :invalid_uint32 },
        { max_uint32() + 1, :invalid_uint32 },
        { :not_an_integer,  :invalid_uint32 },
      ]
end
