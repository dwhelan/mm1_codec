defmodule WAP.ShortIntegerTest do
  use ExUnit.Case

  use MM1.Codecs.TestExamples,
      codec: WAP.ShortInteger,
      examples: [
        {<<128>>, 0},
        {<<255>>, 127},
      ],

      decode_errors: [
        {<<127>>, :most_signficant_bit_must_be_1, <<127>>, <<127>>},
      ],

      new_errors: [
        {-1,  :must_be_an_integer_between_0_and_127},
        {128, :must_be_an_integer_between_0_and_127},
        {"x", :must_be_an_integer_between_0_and_127},
      ]
end

defmodule WAP2.ShortIntegerTest do
  use ExUnit.Case

  use MM1.Codecs2.TestExamples,
      codec: WAP2.ShortInteger,
      examples: [
        {<<128>>, {  0, <<>>}},
        {<<255>>, {127, <<>>}},
      ],

      decode_errors: [
        {<<127>>, :most_signficant_bit_must_be_1},
      ],

      encode_errors: [
        {-1,  :must_be_an_integer_between_0_and_127},
        {128, :must_be_an_integer_between_0_and_127},
        {"x", :must_be_an_integer_between_0_and_127},
      ]
end

