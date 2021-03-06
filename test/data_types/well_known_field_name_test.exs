defmodule MMS.WellKnownFieldNameTest do
  use MMS.CodecTest
  alias MMS.WellKnownFieldName

  use MMS.TestExamples,
      codec: WellKnownFieldName,

      examples: [
        {<< s(0) >>, 0},
      ],

      decode_errors: [
        {<<127>>, {:short_integer, <<127>>, [out_of_range: 127]}},
      ]
end
