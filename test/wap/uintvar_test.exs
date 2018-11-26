defmodule WAP.UintvarTest do
  use ExUnit.Case

  use MM1.CodecExamples,
      module: WAP.Uintvar,
      examples: [
        {<<0>>, 0},
        {<<127>>, 127},
        {<<129, 0>>, 128},
        {<<255, 127>>, 16_383},
        {<<129, 128, 0>>, 16_384},
        {<<255, 255, 127>>, 2_097_151},
        {<<129, 128, 128, 0>>, 2_097_152},
        {<<255, 255, 255, 127>>, 268_435_455},
        {<<129, 128, 128, 128, 0>>, 268_435_456},
        {<<255, 255, 255, 255, 127>>, 34_359_738_367},
      ],

      decode_errors: [
        {<<255, 255, 255, 255, 255, 127>>, :must_be_5_bytes_or_less, <<255, 255, 255, 255, 255, 127>>}
      ]
 end
