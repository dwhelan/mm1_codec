defmodule MMS.LengthLimiterTest.Ok do
  import MMS.LengthLimiter
  defcodec as: MMS.CodecTest.Ok, length: MMS.ValueLength
end

defmodule MMS.LengthLimiterOkTest do
  use MMS.CodecTest
  import MMS.LengthLimiterTest.Ok

  codec_examples [
    {"", <<1, 42>>, 42},
  ]

  decode_errors [
    {"insufficient bytes",     <<1>>},
    {"too few bytes consumed", <<2, 42, 0>>},
  ]
end

defmodule MMS.LengthLimiterTest.Error do
  import MMS.LengthLimiter
  defcodec as: MMS.CodecTest.Error, length: MMS.ValueLength
end

defmodule MMS.LengthLimiterErrorTest do
  use MMS.CodecTest
  import MMS.LengthLimiterTest.Error

  decode_errors [
    {"", <<1, 42>>, data_type: :reason},
  ]

  encode_errors [
    {"", 42, data_type: :reason},
  ]
end
