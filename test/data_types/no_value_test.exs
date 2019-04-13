defmodule MMS.NoValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.NoValue,

      examples: [
        { <<0>>, :no_value} ,
      ],

      decode_errors: [
        { <<1>>, {:no_value, <<1>>, out_of_range: 1}} ,
      ]
end

