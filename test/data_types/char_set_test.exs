defmodule MMS.CharSetTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.CharSet,

      examples: [
        { << s(0) >>,           :any_charset       },
        { << s(119) >>,         :csKZ1048  },
        { << l(2), 1000::16 >>, :csUnicode },
      ],

      decode_errors: [
        { << 0 >>,              {:char_set, << 0 >>,            [:integer_value, :long_integer, :must_have_at_least_one_data_byte]} },
        { << s(120) >>,         {:char_set, <<s(120)>>,         %{out_of_range: 120}}  },
        { << l(2), 9999::16 >>, {:char_set, <<l(2), 9999::16>>, %{out_of_range: 9999}} },
      ],

      encode_errors: [
        { :unknown_charset, {:char_set, :unknown_charset, :out_of_range} },
      ]
end
