defmodule MMS.ValueLengthTest do
  use MMS.CodecTest

  length_quote = 31

  use MMS.TestExamples,
      codec: MMS.ValueLength,

      examples: [
#        { <<1>>,  1  },
#        { <<30>>, 30 },

        { <<length_quote, 31>>,                   31           },
        { <<length_quote>> <> max_uint32_bytes(), max_uint32() },
      ],

      decode_errors: [
        { <<32>>,                                         :invalid_value_length },
        { <<length_quote>>,                               :invalid_value_length },
        { <<length_quote, 128, 255, 255, 255, 255, 127>>, :invalid_value_length },
      ],

      encode_errors: [
        { -1,               :invalid_value_length },
        { max_uint32() + 1, :invalid_value_length },
      ]
end

