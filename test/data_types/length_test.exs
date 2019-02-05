defmodule MMS.LengthTest do
  use MMS.CodecTest

  length_quote = 31

  use MMS.TestExamples,
      codec: MMS.Length,

      examples: [
        { <<length_quote, 0>>,                    0            },
        { <<length_quote>> <> max_uint32_bytes(), max_uint32() },
      ],

      decode_errors: [
        { <<>>,             {:invalid_length, <<>>, :no_bytes} },
        { <<32>>,           {:invalid_length, " ", :missing_length_quote} },
        { <<length_quote>>, {:invalid_length, <<31>>, {:invalid_uint32, "", :no_bytes}} },
      ],

      encode_errors: [
        { -1, {:invalid_length, -1, {:invalid_uint32, -1, :out_of_range}} },
      ]
end

