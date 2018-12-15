defmodule WAP2.ValueLengthTest do
  use ExUnit.Case

  max_value = 0xffffffff
  length_quote = 31

  use MM1.Codecs2.TestExamples,
      codec: WAP2.ValueLength,
      examples: [
        {<<0>>,  { 0, <<>>}},
        {<<30>>, {30, <<>>}},

        {<<length_quote, 31>>, {31, <<>>}},
        {<<length_quote, 32>>, {32, <<>>}},

        {<<length_quote, 143, 255, 255, 255, 127>>, {max_value, <<>>}},
      ],

      decode_errors: [
        {<<32>>, :first_byte_must_be_less_than_32},
        {<<length_quote, 128, 255, 255, 255, 255, 127>>, :uintvar_length_must_be_5_bytes_or_less},
      ],

      encode_errors: [
        {-1,              :must_be_an_unsigned_32_bit_integer},
        {max_value + 1,   :must_be_an_unsigned_32_bit_integer},
        {:not_an_integer, :must_be_an_unsigned_32_bit_integer},
      ]
end

