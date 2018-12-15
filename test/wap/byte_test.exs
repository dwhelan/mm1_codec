defmodule WAP2.ByteTest do
  use ExUnit.Case

  use MM1.Codecs2.TestExamples,
      codec: WAP2.Byte,
      examples: [
        {<<0>>,   {  0, <<>>}},
        {<<255>>, {255, <<>>}},
      ],

      encode_errors: [
        {  -1, :must_be_an_integer_between_0_and_255},
        { 256, :must_be_an_integer_between_0_and_255},
        { "x", :must_be_an_integer_between_0_and_255},
      ]
end
