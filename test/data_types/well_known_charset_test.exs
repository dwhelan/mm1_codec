defmodule MMS.WellKnownCharsetTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.WellKnownCharset,

      examples: [
        { << s(0) >>,           :AnyCharset },
        { << s(3) >>,           :ASCII      },
        { << s(106) >>,         :UTF8       },
        { << l(2), 1000::16 >>, :Unicode    },
      ],

      decode_errors: [
        { << 0 >>,              {:well_known_charset, << 0 >>,            [:integer_value, :long_integer, :must_have_at_least_one_data_byte]} },
        { << s(120) >>,         {:well_known_charset, <<s(120)>>,         %{out_of_range: 120}}  },
        { << l(2), 9999::16 >>, {:well_known_charset, <<l(2), 9999::16>>, %{out_of_range: 9999}} },
      ],

      encode_errors: [
        { :unknown_charset, {:well_known_charset, :unknown_charset, :out_of_range} },
      ]
end
