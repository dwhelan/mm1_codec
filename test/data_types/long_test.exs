defmodule MMS.LongTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Long,

      examples: [
        { << l(1), 0 >>,        0          },
        { << l(1), 255 >>,      255        },
        { << l(2), 1,   0 >>,   256        },
        { << l(2), 255, 255 >>, 65_535     },
        { max_long_bytes(),     max_long() },
      ],

      decode_errors: [
        { <<0>>,  {:long, <<0>>,  [:multi_octet_integer, :must_have_at_least_one_data_byte]}},
        { <<1>>,  {:long, <<1>>,  [:short_length, %{length: 1, available_bytes: 0}]} },
        { <<31>>, {:long, <<31>>, [:short_length, %{out_of_range: 31}]} },
      ],

      encode_errors: [
        { -1,           {:long, -1,           :out_of_range} },
        { max_long()+1, {:long, max_long()+1, :out_of_range} },
      ]
end
