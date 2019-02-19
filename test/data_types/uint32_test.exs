defmodule MMS.Uint32Test do
  use MMS.CodecTest

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
        { <<>>,                      {:invalid_uint32, <<>>, :no_bytes} },
        { <<128>>,                   {:invalid_uint32, <<128>>, :first_byte_cannot_be_128} },
        { <<144, 128, 128, 128, 0>>, {:invalid_uint32, <<144, 128, 128, 128, 0>>, %{out_of_range: max_uint32()+1}} },
      ],

      encode_errors: [
        { -1,               {:invalid_uint32, -1, :out_of_range} },
        { max_uint32() + 1, {:invalid_uint32, max_uint32() + 1, :out_of_range} },
      ]
end
