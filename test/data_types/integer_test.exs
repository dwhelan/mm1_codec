defmodule MMS.IntegerTest do
  use MMS.Test

  use MMS.TestExamples,
      codec: MMS.Integer,

      examples: [
        { << s(0) >>,           0      },
        { << s(127) >>,         127    },
        { << l(1), 128 >>,      128    },
        { << l(2), 255, 255 >>, 65_535 },
      ],

      decode_errors: [
        { <<0>>,  :invalid_integer },
      ],

      encode_errors: [
        { -1,              :invalid_integer },
        { max_long()+1,    :invalid_integer },
        { :not_an_integer, :invalid_integer },
      ]
end

