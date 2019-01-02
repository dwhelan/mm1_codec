defmodule MMS.IntegerTest do
  use ExUnit.Case
  import MMS.Test

  use MMS.TestExamples,
      codec: MMS.Integer,
      examples: [
        {<< l(2),   1,   0>>,   256},
        {<<255>>, 127},
      ],

      decode_errors: [
#        {<<127>>, :invalid_short},
      ],

      encode_errors: [
#        {-1,  :invalid_short},
#        {128, :invalid_short},
#        {"x", :invalid_short},
      ]
end

