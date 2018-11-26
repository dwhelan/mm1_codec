defmodule WAP.ShortLengthTest do
  use ExUnit.Case

  use MM1.CodecExamples, codec: WAP.ShortLength,
    examples: [
      {<< 0>>,  0},
      {<<30>>, 30},
    ],

    decode_errors: [
      {<<31>>, :must_be_less_than_31, 31},
    ],

    new_errors: [
      {  -1, :must_be_an_integer_between_0_and_30},
      {  31, :must_be_an_integer_between_0_and_30},
      {1.23, :must_be_an_integer_between_0_and_30},
      { "x", :must_be_an_integer_between_0_and_30},
      {:foo, :must_be_an_integer_between_0_and_30},
    ]
end
