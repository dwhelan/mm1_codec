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
        { <<1>>,  {:invalid_media, <<1>>,  [:invalid_well_known_media, :invalid_integer, :invalid_long, :invalid_short_length, %{available_bytes: 0, length: 1}]} },
        { <<31>>, {:invalid_media, <<31>>, [:invalid_well_known_media, :invalid_integer, :invalid_long, :invalid_short_length, %{out_of_range: 31}]}              },
        { "x",    {:invalid_media, "x",    [:invalid_text, :missing_end_of_string_0_byte]} },
      ],

      encode_errors: [
        { "x\0", {:invalid_media, "x\0", [:invalid_text, :contains_end_of_string_0]} },
      ]
end
