defmodule MMS.TimeTest do
  use MMS.CodecTest

  length_quote = 31

  abs = s(0)
  rel = s(1)

  use MMS.TestExamples,
      codec: MMS.Time,

      examples: [
        { << l(3), abs, l(1), 0 >>, DateTime.from_unix!(0) }, # short length, absolute
        { << l(3), rel, l(1), 0 >>, 0                      }, # short length, relative

        { <<length_quote, l(32), rel>> <> max_long_bytes(), max_long() }, # uint32 length, relative

        # Note: cannot test an absolute max_long converted to a DateTime because it is too large for DateTime.from_unix
      ],

      decode_errors: [
        { << l(3), abs, l(0) >>,  {:time, <<l(3), abs, l(0)>>, [:short_length, %{available_bytes: 2, short_length: 3}]} },
        { << l(32) >>,            {:time, <<l(32)>>,           [:value_length, :does_not_start_with_a_short_length_or_length_quote]} },
        { << l(3), 0, l(1), 0 >>, {:time, <<3, 0, 1, 0>>,      [:value_length_list, :list, %{error: {:short_integer, <<0, 1, 0>>, [out_of_range: 0]}, length: 3, values: []}]} },
      ],

      encode_errors: [
      ]
end
