defmodule MMS.ShortLengthTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ShortLength,
      examples: [
        {<< 1>>,  1},
        {<<30>>, 30},
      ],

      decode_errors: [
        {<<31>>, :invalid_short_length},
      ],

      encode_errors: [
        {-1,  :invalid_short_length},
        {31,  :invalid_short_length},
        {"x", :invalid_short_length},
      ]
end
