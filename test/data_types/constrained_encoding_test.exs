defmodule MMS.ConstrainedEncodingTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.ConstrainedEncoding,

      examples: [
        # Extension media
        { << 0 >>,         ""          },
        { << 32, 0 >>,     " "        },
        { << 0x7f, 0 >>,   <<0x7f>>      },
        { "other/other\0", "other/other" },

        # Short-integer
        { << s(0) >>, 0},
        { << s(127) >>, 127},
      ],

      decode_errors: [
        { "x",                        {:constrained_encoding, "x",       [:text, :missing_end_of_string]} },
        { <<invalid_short_length()>>, {:constrained_encoding, <<invalid_short_length()>>,     :must_start_with_a_short_integer_or_char} },
        { <<1>>,                      {:constrained_encoding, <<1>>,     :must_start_with_a_short_integer_or_char} },
      ],

      encode_errors: [
        { "x\0", {:constrained_encoding, "x\0", [:text, :contains_end_of_string]} },
      ]
end
