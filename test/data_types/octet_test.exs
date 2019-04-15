defmodule MMS.OctetTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Octet,

      examples: [
        { << 0 >>,   0   },
        { << 255 >>, 255 },
      ],

      encode_errors: [
        { -1,  {:octet, -1,  :out_of_range} },
        { 256, {:octet, 256, :out_of_range} },
      ]

  import MMS.Octet

  codec_test "min", <<0>>, 0
  codec_test "max", <<0>>, 0

  encode_error "too small", -1, :out_of_range
  encode_error "too large", 256, :out_of_range
  encode_error "bad value type", :bad_type, :out_of_range

end
