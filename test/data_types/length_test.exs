defmodule MMS.LengthTest do
  use MMS.CodecTest

  length_quote = 31

  use MMS.TestExamples,
      codec: MMS.Length,

      examples: [
        { << length_quote, 0>>,                    0            },
        { << length_quote>> <> max_uint32_bytes(), max_uint32() },
      ],

      decode_errors: [
        { <<>>,             {:length, <<>>,   :no_bytes} },
        { <<32>>,           {:length, <<32>>, :missing_length_quote} },
        { <<length_quote>>, {:length, <<31>>, [:uint32, :no_bytes]} },
      ],

      encode_errors: [
        { -1, {:length, -1, [:uint32, :out_of_range]} },
      ]
end
