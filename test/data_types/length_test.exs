defmodule MMS.LengthTest do
  use MMS.CodecTest
  import MMS.Length

  @max max_uintvar_integer()
  @max_bytes max_uintvar_integer_bytes()

  codec_examples [
    {"0", <<0>>, 0},
    {"max uintvar integer", @max_bytes, @max},
  ]

  decode_errors [
    {"128 as first byte", <<128>>, [:uintvar_integer, :first_byte_cannot_be_128]},
  ]

  encode_errors [
    {"negative", -1, [:uintvar_integer, :out_of_range]},
  ]
end
