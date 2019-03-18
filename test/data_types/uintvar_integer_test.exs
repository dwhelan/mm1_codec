defmodule MMS.UintvarIntegerTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.UintvarInteger,

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
        { <<>>,                      {:uintvar_integer, <<>>, :no_bytes} },
        { <<128>>,                   {:uintvar_integer, <<128>>, :first_byte_cannot_be_128} },
        { <<144, 128, 128, 128, 0>>, {:uintvar_integer, <<144, 128, 128, 128, 0>>, %{out_of_range: max_uint32()+1}} },
      ],

      encode_errors: [
        { -1,               {:uintvar_integer, -1, :out_of_range} },
        { max_uint32() + 1, {:uintvar_integer, max_uint32() + 1, :out_of_range} },
      ]
end
