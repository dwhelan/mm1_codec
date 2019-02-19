defmodule MMS.EncodedStringValueTest do
  use MMS.CodecTest

  alias MMS.EncodedStringValue

  string30     = String.duplicate "x", 30
  length_quote = 31

  use MMS.TestExamples,
      codec: EncodedStringValue,

      examples: [
        # Not encoded
        { <<0>>,     ""  },
        { <<"x\0">>, "x" },

        # Encoded with short length
        { << l(3), s(106), "x\0" >>,         {"x", :csUTF8}},     # short charset
        { << l(5), l(2), 1000::16, "x\0" >>, {"x", :csUnicode} }, # long charset

        # Encoded with uint32 length
        { << length_quote, l(32), s(106) >> <> string30 <> <<0>>, {string30, :csUTF8} },
      ],

      decode_errors: [
        { <<"x">>,               {:invalid_encoded_string_value, "x",                   [:invalid_text_string, :invalid_text, :missing_end_of_string_0_byte]} },
        { <<l(2), s(106), "x">>, {:invalid_encoded_string_value, <<l(2), s(106), "x">>, %{length: {2, <<2>>}, values: [:csUTF8, error(:invalid_text_string, "x", [:invalid_text, :missing_end_of_string_0_byte])]} }},
      ],

      encode_errors: [
        { "x\0",            {:invalid_encoded_string_value, "x\0", [:invalid_text, :contains_end_of_string_0]} },
        { {"x\0", :csUTF8}, {:invalid_encoded_string_value, {"x\0", :csUTF8}, [<<s(106)>>, error(:invalid_text, "x\0", :contains_end_of_string_0)]} },      ]
end

