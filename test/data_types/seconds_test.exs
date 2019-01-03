defmodule MMS.SecondsTest do
  use MMS.Test

  length_quote = 31

  abs = s(0)
  rel = s(1)

  use MMS.TestExamples,
      codec: MMS.Seconds,

      examples: [
        { << l(3), abs, l(1), 0 >>, DateTime.from_unix!(0) }, # short length, absolute
        { << l(3), rel, l(1), 0 >>, 0                      }, # short length, relative

        { <<length_quote, l(32), rel>> <> max_long_bytes(), max_long() }, # uint32 length, relative

        # Note: cannot test an absolute max_long converted to a DateTime because it is too large for DateTime.from_unix
      ],

      decode_errors: [
        { << l(32) >>,               :invalid_seconds }, # length error
        { << l(3), 0,    l(1), 0 >>, :invalid_seconds }, # absolute/relative token error
        { << l(3), abs, l(0)    >>, :invalid_seconds }, # value error
      ],

      encode_errors: [
        { -1,             :invalid_seconds },
        { max_long() + 1, :invalid_seconds },
      ]
end
