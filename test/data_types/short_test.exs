defmodule MMS.ShortTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Short,

      examples: [
        {<<128>>,   0},
        {<<255>>, 127},
      ],

      decode_errors: [
        {<<127>>, {:short, <<127>>, [out_of_range: 127]}},
      ]
end

