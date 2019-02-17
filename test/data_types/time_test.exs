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
        { << l(32) >>,              {:invalid_time, <<l(32)>>,      {:invalid_value_length, <<l(32)>>, :does_not_start_with_a_short_length_or_length_quote}} },
        { << l(3), 0,   l(1), 0 >>, {:invalid_time, <<3, 0, 1, 0>>, %{length: {3, <<3>>}, values: [error: :invalid_short]}} },
        { << l(3), abs, l(0)    >>, {:invalid_time, <<3, 128, 0>>,  {:invalid_short_length, <<3, 128, 0>>, {:insufficient_bytes, 3}}} },
      ],

      encode_errors: [
        { -1,             [<<129>>, {:error, {:invalid_long, -1, :out_of_range}}] },
        { max_long() + 1, [<<129>>, {:error, {:invalid_long, 1766847064778384329583297500742918515827483896875618958121606201292619776, :out_of_range}}] },
      ]
end
