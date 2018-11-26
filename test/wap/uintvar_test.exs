defmodule WAP.UintvarTest do
  use ExUnit.Case

  max_value = 0xffffffff

  use MM1.CodecExamples, codec: WAP.Uintvar,
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
        {<<143, 255, 255, 255, 127>>, max_value},
      ],

      decode_errors: [
        {<<128, 255, 255, 255, 255, 127>>, :must_be_5_bytes_or_less, 34_359_738_367}
      ],

      new_errors: [
        {         -1, :must_be_an_unsigned_32_bit_integer},
        {       1.23, :must_be_an_unsigned_32_bit_integer},
        {        "x", :must_be_an_unsigned_32_bit_integer},
        {       :foo, :must_be_an_unsigned_32_bit_integer},
        {max_value+1, :must_be_an_unsigned_32_bit_integer},
      ]
 end
