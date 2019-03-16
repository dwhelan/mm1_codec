defmodule MMS.LongIntegerTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.LongInteger,

      examples: [
        { << l(1), 0 >>,        0          },
        { << l(1), 255 >>,      255        },
        { << l(2), 1,   0 >>,   256        },
        { << l(2), 255, 255 >>, 65_535     },
        { max_long_bytes(),     max_long() },
      ],

      decode_errors: [
        { <<0>>,                      {:long_integer, <<0>>,                      [:multi_octet_integer, :must_have_at_least_one_data_byte]}},
        { <<1>>,                      {:long_integer, <<1>>,                      [:short_length, %{short_length: 1, available_bytes: 0}]} },
        { <<max_short_length() + 1>>, {:long_integer, <<max_short_length() + 1>>, [:short_length, %{out_of_range: max_short_length()+1}]} },
      ],

      encode_errors: [
        { -1,           {:long_integer, -1,           :out_of_range} },
        { max_long()+1, {:long_integer, max_long()+1, :out_of_range} },
      ]
end
