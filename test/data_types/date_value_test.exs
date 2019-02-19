defmodule MMS.DateValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.DateValue,

      examples: [
        { << l(1), 0>>,   DateTime.from_unix! 0   },
        { << l(1), 127>>, DateTime.from_unix! 127 },
      ],

      decode_errors: [
        {<<32>>,        {:date_value, <<32>>,       [:long, :short_length, %{out_of_range: 32}]} },
        {<<l(2), 32>>,  {:date_value, <<l(2), 32>>, [:long, :short_length, %{length: 2, available_bytes: 1}]} },
      ],

      encode_errors: [
        {DateTime.from_unix!(-1), {:date_value, DateTime.from_unix!(-1), :cannot_be_before_1970}},
      ]
end
