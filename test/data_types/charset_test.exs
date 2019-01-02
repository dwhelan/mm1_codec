defmodule MMS.CharsetTest do
  use ExUnit.Case
  import MMS.Test

  use MMS.TestExamples,
      codec: MMS.Charset,
      examples: [
        { << s(0) >>,           :any       },
        { << s(119) >>,         :csKZ1048  },
        { << l(2), 1000::16 >>, :csUnicode },
      ],

      decode_errors: [
        { << s(120) >>,         :invalid_charset },
        { << l(2), 9999::16 >>, :invalid_charset },
      ],

      encode_errors: [
        { :not_a_charset, :invalid_charset },
        { 120,            :invalid_charset },
        { 9999,           :invalid_charset },
      ]
end


