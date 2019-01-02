defmodule MMS.CharsetTest do
  use ExUnit.Case
  import MMS.Test

  use MMS.TestExamples,
      codec: MMS.Charset,
      examples: [
        { <<128>>,            :any       },
        { <<129>>,            :other     },
        { <<l(2), 1000::16>>, :csUnicode },
      ],

      decode_errors: [
        { <<127>>,            :invalid_charset },
        { <<l(2), 9999::16>>, :invalid_charset },
      ]
end


