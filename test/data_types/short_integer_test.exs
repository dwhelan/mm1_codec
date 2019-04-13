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
end

