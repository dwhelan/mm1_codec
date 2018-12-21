defmodule MMS.IntegerTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Integer,
      examples: [
        {<<2,   1,   0>>,   256},
#        {<<255>>, 127},
      ],

      decode_errors: [
#        {<<127>>, :invalid_short_integer},
      ],

      encode_errors: [
#        {-1,  :invalid_short_integer},
#        {128, :invalid_short_integer},
#        {"x", :invalid_short_integer},
      ]
end

