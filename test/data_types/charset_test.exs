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
        { << 0 >>,              {:invalid_charset, << 0 >>, {:invalid_integer, <<0>>, {:invalid_long, <<0>>, :must_have_at_least_one_data_byte}}} },
        { << s(120) >>,         {:invalid_charset, <<s(120)>>, :out_of_range} },
        { << l(2), 9999::16 >>, {:invalid_charset, <<l(2), 9999::16>>, :out_of_range} },
      ],

      encode_errors: [
        { :unknown_charset, {:invalid_charset, :unknown_charset, :out_of_range} },
      ]
end
