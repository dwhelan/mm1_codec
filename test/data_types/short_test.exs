defmodule MMS.ShortTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Short,
      examples: [
        {<<128>>,   0},
        {<<255>>, 127},
      ],

      decode_errors: [
        {<<127>>, :invalid_short},
      ],

      encode_errors: [
        {-1,  :invalid_short},
        {128, :invalid_short},
        {"x", :invalid_short},
      ]
end

