defmodule MMS.IntegerTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Integer,
      examples: [
        {<<2,   1,   0>>,   256},
#        {<<255>>, 127},
      ],

      decode_errors: [
#        {<<127>>, :most_signficant_bit_must_be_1},
      ],

      encode_errors: [
#        {-1,  :must_be_an_integer_between_0_and_127},
#        {128, :must_be_an_integer_between_0_and_127},
#        {"x", :must_be_an_integer_between_0_and_127},
      ]
end

