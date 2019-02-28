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
        { "x",    {:media, "x",       [:text, :missing_end_of_string]} },
        { <<invalid_short_length()>>, {:media, <<invalid_short_length()>>, [:well_known_media, :integer, :long, :short_length, %{out_of_range: invalid_short_length()}]}              },
        { <<1>>,  {:media, <<1>>,     [:well_known_media, :integer, :long, :short_length, %{available_bytes: 0, short_length: 1}]} },
      ],

      encode_errors: [
        { "x\0", {:media, "x\0", [:text, :contains_end_of_string]} },
      ]
end
