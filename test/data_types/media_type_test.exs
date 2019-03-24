defmodule MMS.MediaTypeTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.MediaType,

      examples: [
        # Well known media
        { << s(0) >>, {"*/*"} },

        # Extension media
        { << 0 >>,         {""}          },
        { << 32, 0 >>,     {" "}        },
        { << 0x7f, 0 >>,   {<<0x7f>>}      },
        { "other/other\0", {"other/other"} },
      ],

      decode_errors: [
        { "x",                        {:media_type, "x",       [:text, :missing_end_of_string]} },
        { <<invalid_short_length()>>, {:media_type, <<invalid_short_length()>>,     :must_start_with_a_short_integer_or_char} },
        { <<1>>,                      {:media_type, <<1>>,     :must_start_with_a_short_integer_or_char} },
      ],

      encode_errors: [
        { {"x\0"}, {:media_type, {"x\0"}, [:text, :contains_end_of_string]} },
      ]
end
