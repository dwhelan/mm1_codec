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
        { <<1>>,  {:media, <<1>>,  [:well_known_media, :integer, :long, :short_length, %{available_bytes: 0, length: 1}]} },
        { <<31>>, {:media, <<31>>, [:well_known_media, :integer, :long, :short_length, %{out_of_range: 31}]}              },
        { "x",    {:media, "x",    [:text, :missing_end_of_string]} },
      ],

      encode_errors: [
        { "x\0", {:media, "x\0", [:text, :contains_end_of_string]} },
      ]
end
