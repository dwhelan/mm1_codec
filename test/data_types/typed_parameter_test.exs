defmodule MMS.TypedParameterTest do
  use MMS.CodecTest
  alias MMS.{CompactValue, TextValue}

  use MMS.TestExamples,
      codec: MMS.TypedParameter,

      examples: [
        { << s(0),  1     >>, {:q, "00"} },
        { << s(29), "a\0" >>, {:path, "a"} },
      ],

      decode_errors: [
        { << s 30 >>,    {:typed_parameter, << s 30 >>,    [:well_known_parameter_token, out_of_range: 30]} },
        { << s(8), 1 >>, {:typed_parameter, << s(8), 1 >>, [:typed_value, %{cannot_be_decoded_as: [CompactValue, TextValue]}] } },
      ],

      encode_errors: [
        { {:foo, 0},      {:typed_parameter, :foo,           [:well_known_parameter_token, :out_of_range]} },
        { {:padding, :a}, {:typed_parameter, {:padding, :a}, [:typed_value, %{cannot_be_encoded_as: [CompactValue, TextValue]}]} },
      ]
end
