defmodule MMS.UintvarIntegerTest do
  use MMS.CodecTest

  import MMS.UintvarInteger

  @max max_uintvar_integer()
  @max_bytes max_uintvar_integer_bytes()

  @too_large @max + 1
  @too_large_bytes <<144, 128, 128, 128, 0>>

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

    {"max uintvar integer", @max_bytes, @max},
  ]

  decode_errors [
    {"128 as first byte", <<128>>,          :first_byte_cannot_be_128},
    {"too large",         @too_large_bytes, out_of_range: @too_large},
  ]

  encode_errors [
    {"negative", -1,           :out_of_range},
    {"too large", @too_large, :out_of_range},
  ]
end
