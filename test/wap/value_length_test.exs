defmodule WAP.ValueLengthTest do
  use ExUnit.Case

  use MM1.CodecExamples, module: WAP.ValueLength,
    examples: [
      {<<0>>,       0},
      {<<30>>,     30},
      {<<31, 31>>, 31},
      {<<31, 32>>, 32},

      {<<31, 143, 255, 255, 255, 127>>, 0xffffffff},
    ],

    decode_errors: [
      {<<32>>, :first_byte_must_be_less_than_32, 32}
    ]
end
