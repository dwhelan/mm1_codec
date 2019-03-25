defmodule MMS.WellKnownFieldNameTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.WellKnownFieldName,

      examples: [
        {<<128>>,   0},
        {<<255>>, 127},
      ],

      decode_errors: [
        {<<127>>, {:short_integer, <<127>>, [out_of_range: 127]}},
      ]
end

