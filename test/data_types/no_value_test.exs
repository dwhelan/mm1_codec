defmodule MMS.NoValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.NoValue,

      examples: [
        { <<0>>, :no_value} ,
      ],

      decode_errors: [
        { <<1>>, :invalid_no_value }
      ],

      encode_errors: [
        { :not_no_value, :invalid_no_value }
      ]
end

