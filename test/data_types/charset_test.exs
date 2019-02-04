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
        { << 0 >>,         {:invalid_charset, << 0 >>, :invalid_integer} },
        { << s(120) >>,         {:invalid_charset, <<s(120)>>, :not_found} },
        { << l(2), 9999::16 >>, {:invalid_charset, <<l(2), 9999::16>>, :not_found} },
      ],

      encode_errors: [
        { :unknown_charset, {:invalid_charset, :unknown_charset, :not_found} },
      ]
end
