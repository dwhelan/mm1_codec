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
        { "x",                        {:media_type, "x",                        [text: :missing_end_of_string,               well_known_media: [:short_integer, {:out_of_range, 120}]]}, },
        { <<invalid_short_length()>>, {:media_type, <<invalid_short_length()>>, [text: :first_byte_must_be_a_zero_or_a_char, well_known_media: [:short_integer, {:out_of_range, 31}]]} },
        { <<1>>,                      {:media_type, <<1>>,                      [text: :first_byte_must_be_a_zero_or_a_char, well_known_media: [:short_integer, {:out_of_range, 1}]]} },
      ],

      encode_errors: [
        { :"bad media", {:media_type, :"bad media", [:well_known_media, :out_of_range]} },
        { "x\0",        {:media_type, "x\0",        [:text, :contains_end_of_string]} },
      ]
end
