defmodule MMS.LengthTest do
  use ExUnit.Case
  import MMS.DataTypes

  length_quote = 31

  use MMS.TestExamples,
      codec: MMS.Length,
      examples: [
        {<< 1>>,  1},
        {<<30>>, 30},

        {<<length_quote, 31>>, 31},
        {<<length_quote, 32>>, 32},

        {<<length_quote, 143, 255, 255, 255, 127>>, max_uint32()},
      ],

      decode_errors: [
        {<<32>>, :invalid_length},
        {<<length_quote, 128, 255, 255, 255, 255, 127>>, :uint32_length_must_be_5_bytes_or_less},
      ],

      encode_errors: [
        {-1,               :must_be_a_uint32},
        {max_uint32() + 1, :must_be_a_uint32},
        {:not_an_integer,  :must_be_a_uint32},
      ]
end

