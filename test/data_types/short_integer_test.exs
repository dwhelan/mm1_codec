defmodule MMS.ShortIntegerTest do
  use MMS.CodecTest
  alias MMS.ShortInteger
  import ShortInteger

  use MMS.TestExamples,
      codec: ShortInteger,

      examples: [
        {<<128>>,   0},
        {<<255>>, 127},
      ],

      decode_errors: [
        {<<127>>, {:short_integer, <<127>>, [out_of_range: 127]}},
      ]

  test "decodeable?" do
    refute decodeable? << 0 >>
    refute decodeable? << 127 >>
    assert decodeable? << s(0) >>
    assert decodeable? << s(127) >>
  end

  test "encodeable?" do
    assert encodeable? 0
    assert encodeable? 127
    refute encodeable? -1
    refute encodeable? 128
    refute encodeable? "a"
  end
end

