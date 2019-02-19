defmodule MMS.ShortTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Short,

      examples: [
        {<<128>>,   0},
        {<<255>>, 127},
      ],

      decode_errors: [
        {<<127>>, :invalid_short},
      ]
end

