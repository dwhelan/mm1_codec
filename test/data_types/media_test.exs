defmodule MMS.MediaTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Media,
      examples: [
        # Well known media
        {<<0x80>>, "*/*"},
        {<<0xff>>, 0x7f },

        # Extension media
        {<<0>>,                <<>>         },
        {<<0x7f, 0>>,          <<0x7f>>     },
        {<<"other/other", 0>>, "other/other"},
      ],

      decode_errors: [
        {<<"x">>, :missing_terminator},
      ]
end
