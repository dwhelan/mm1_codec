defmodule MMS.ShortLengthTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ShortLength,
      examples: [
        {<< 1>>,  1},
        {<<30>>, 30},
      ],

      decode_errors: [
        {<<31>>, :must_be_an_integer_between_1_and_30},
      ],

      encode_errors: [
        {-1,  :must_be_an_integer_between_1_and_30},
        {31,  :must_be_an_integer_between_1_and_30},
        {"x", :must_be_an_integer_between_1_and_30},
      ]
end
