defmodule MMS.MediaTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Media,

      examples: [
        # Well known media
        { << s(0) >>, "*/*" },

        # Extension media
        { << 0 >>,         <<>>          },
        { << 32, 0 >>,     <<32>>        },
        { << 0x7f, 0 >>,   <<0x7f>>      },
        { "other/other\0", "other/other" },
      ],

      decode_errors: [
        { <<1>>,  {:invalid_media, <<1>>,  {:invalid_integer, <<1>>, {:invalid_long, <<1>>, {:invalid_short_length, <<1>>, {:insufficient_bytes, 1}}}}} },
        { <<31>>, {:invalid_media, <<31>>, {:invalid_integer, <<31>>, {:invalid_long, <<31>>, {:invalid_short_length, <<31>>, 31}}}} },
        { "x",    {:invalid_media, "x",    :missing_end_of_string_0_byte} },
      ],

      encode_errors: [
        { "x\0", {:invalid_media, "x\0", {:invalid_text, "x\0", :contains_end_of_string_0}} },
      ]
end
