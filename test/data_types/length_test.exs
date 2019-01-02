defmodule MMS.LengthTest do
  use ExUnit.Case
  import MMS.DataTypes

  length_quote = 31

  use MMS.TestExamples,
      codec: MMS.Length,

      examples: [
        { <<1>>,  1  },
        { <<30>>, 30 },

        { <<length_quote, 31>>,                   31           },
        { <<length_quote>> <> max_uint32_bytes(), max_uint32() },
      ],

      decode_errors: [
        { <<32>>,                                         :invalid_length },
        { <<length_quote, 128, 255, 255, 255, 255, 127>>, :invalid_length },
      ],

      encode_errors: [
        { -1,               :invalid_length },
        { max_uint32() + 1, :invalid_length },
        { :not_a_length,    :invalid_length },
      ]
end

