defmodule MMS.EncodedStringValueTest do
  use MMS.CodecTest

  alias MMS.EncodedStringValue

  string30 = String.duplicate "x", 30

  use MMS.TestExamples,
      codec: EncodedStringValue,

      examples: [
        # Not encoded
        { <<"x\0">>, "x" },

        # Encoded with short length
        { << l(3), s(106), "x\0" >>,         {"x", :UTF8}    }, # short charset
        { << l(5), l(2), 1000::16, "x\0" >>, {"x", :Unicode} }, # long charset

        # Encoded with uint32 length
        { << length_quote(), l(32), s(106) >> <> string30 <> <<0>>, {string30, :UTF8} },
      ],

      decode_errors: [
        { <<"\0">>,              {:encoded_string_value, <<0>>,                 [:text_string, :text, :must_start_with_a_char]}},
        { <<"x">>,               {:encoded_string_value, "x",                   [:text_string, :text, :missing_end_of_string]} },
        { <<l(2), s(106), "x">>, {:encoded_string_value, <<l(2), s(106), "x">>, [:value_length_list, :list, %{error: {:text_string, "x", [:text, :missing_end_of_string]}, length: 2, values: [:UTF8]}] }},
      ],

      encode_errors: [
        { "x\0",          {:encoded_string_value, "x\0",            [:text_string, :text, :contains_end_of_string]} },
        { {"x\0", :UTF8}, {:encoded_string_value, {"x\0", :UTF8}, [:list, {:text_string, "x\0", [:text, :contains_end_of_string]}]} },
      ]
end

