defmodule MMS.MediaTest do
  use MMS.Test

  use MMS.TestExamples,
      codec: MMS.Media,

      examples: [
        # Well known media
        { << s(0) >>, "*/*" },
        { <<0xff>>, 0x7f  },

        # Extension media
        { << 0 >>,               <<>>          },
        { << 32, 0 >>,           <<32>>        },
        { << 0x7f, 0 >>,         <<0x7f>>      },
        { << "other/other\0" >>, "other/other" },
      ],

      decode_errors: [
        { <<1>>,  :invalid_media },
        { <<31>>, :invalid_media },
      ]
end
