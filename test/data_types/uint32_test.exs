defmodule MMS.Uint32Test do
  use MMS.Test

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

        { max_uint32_bytes(), max_uint32() },
      ],

      decode_errors: [
        { <<128>>,                        :invalid_uint32 }, # first byte can never be 128
        { <<144, 128, 128, 128, 0>>,      :invalid_uint32 }, # max_uint32 + 1
        { <<129, 128, 128, 128, 128, 0>>, :invalid_uint32 }, # more than 5 bytes
      ],

      encode_errors: [
        { -1,               :invalid_uint32 },
        { max_uint32() + 1, :invalid_uint32 },
        { :not_an_integer,  :invalid_uint32 },
      ]
end
