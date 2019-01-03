defmodule MMS.LongTest do
  use MMS.Test

  use MMS.TestExamples,
      codec: MMS.Long,

      examples: [
        { << l(1), 0 >>,        0      },
        { << l(1), 255 >>,      255    },
        { << l(2), 1,   0 >>,   256    },
        { << l(2), 255, 255 >>, 65_535 },

        { max_long_bytes(), max_long() }
      ],

      decode_errors: [
        { <<0>>,  :invalid_long },
        { <<1>>,  :invalid_long },
        { <<31>>, :invalid_long },
      ],

      encode_errors: [
        { -1,              :invalid_long },
        { max_long()+1,    :invalid_long },
        { :not_an_integer, :invalid_long },
      ]
end
