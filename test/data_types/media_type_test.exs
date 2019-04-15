defmodule MMS.MediaTypeTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.MediaType,

      examples: [
        # Well known media
        { << s(0) >>, :"*/*" },

        # Extension media
        { << 0 >>,         ""            },
        { << 32, 0 >>,     " "           },
        { << 0x7f, 0 >>,   <<0x7f>>      },
        { "other/other\0", "other/other" },
      ],

      decode_errors: [
        { "x",                        {:media_type, "x",                        [well_known_media: [:short_integer, {:out_of_range, 120}], extension_media: [:text, :missing_end_of_string]]}, },
        { <<invalid_short_length()>>, {:media_type, <<invalid_short_length()>>, [well_known_media: [:short_integer, {:out_of_range,  31}], extension_media: [:text, :must_start_with_a_char]]} },
        { <<1>>,                      {:media_type, <<1>>,                      [well_known_media: [:short_integer, {:out_of_range,   1}], extension_media: [:text, :must_start_with_a_char]]} },
      ],

      encode_errors: [
        { :"bad media", {:media_type, :"bad media", [{:well_known_media, :out_of_range}]}, {:text, :invalid_type}           },
        { "x\0",        {:media_type, "x\0",        [{:well_known_media, :out_of_range}]}, {:text, :contains_end_of_string} },
      ]
end
