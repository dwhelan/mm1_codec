defmodule MMS.CharsetTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Charset,

      examples: [
        { << s(0) >>,           :any       },
        { << s(119) >>,         :csKZ1048  },
        { << l(2), 1000::16 >>, :csUnicode },
      ],

      decode_errors: [
        { << 0 >>,              {:charset, << 0 >>,            [:integer, :long, :multi_octet_integer, :must_have_at_least_one_data_byte]} },
        { << s(120) >>,         {:charset, <<s(120)>>,         %{out_of_range: 120}}  },
        { << l(2), 9999::16 >>, {:charset, <<l(2), 9999::16>>, %{out_of_range: 9999}} },
      ],

      encode_errors: [
        { :unknown_charset, {:charset, :unknown_charset, :out_of_range} },
      ]
end
