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
        { "x",                        {:constrained_encoding, "x",       extension_media: [:text, :missing_end_of_string], short_integer: [out_of_range: 120]} },
        { <<invalid_short_length()>>, {:constrained_encoding, <<invalid_short_length()>>,     extension_media: [:text, :must_start_with_a_char], short_integer: [out_of_range: 31]} },
        { <<1>>,                      {:constrained_encoding, <<1>>,     extension_media: [:text, :must_start_with_a_char], short_integer: [out_of_range: 1]} },
      ],

      encode_errors: [
        { "x\0", {:constrained_encoding, "x\0", extension_media: [:text, :contains_end_of_string], short_integer: :out_of_range} },
      ]
end
