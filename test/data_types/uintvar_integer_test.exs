defmodule MMS.UintvarIntegerTest do
  use MMS.CodecTest
  import MMS.UintvarInteger

  codec_examples [
    {"0", <<0>>, 0},
    {"127", <<127>>, 127},
    {"128", <<129, 0>>, 128},
    {"16_383", <<255, 127>>, 16_383},
    {"16_384", <<129, 128, 0>>, 16_384},
    {"2_097_151", <<255, 255, 127>>, 2_097_151},
    {"2_097_152", <<129, 128, 128, 0>>, 2_097_152},
    {"268_435_455", <<255, 255, 255, 127>>, 268_435_455},
    {"268_435_456", <<129, 128, 128, 128, 0>>, 268_435_456},

    {"max uintvar integer", max_uintvar_integer_bytes(), max_uintvar_integer()},
  ]

  decode_errors [
    {
      "<<128, ...>>",
      <<128>>,
      {:uintvar_integer, <<128>>, :first_byte_cannot_be_128}
    },
    {
      "#{max_uintvar_integer() + 1}",
      <<144, 128, 128, 128, 0>>,
      {:uintvar_integer, <<144, 128, 128, 128, 0>>, out_of_range: max_uintvar_integer() + 1}
    },
  ]

  encode_errors [
    {"negative", -1, {:uintvar_integer, -1, :out_of_range}},
    {"#{max_uintvar_integer() + 1}", max_uintvar_integer() + 1, {:uintvar_integer, max_uintvar_integer() + 1, :out_of_range}},
  ]
end
