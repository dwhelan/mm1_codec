defmodule MMS.DateValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.DateValue,

      examples: [
        { << l(1), 0>>,   DateTime.from_unix! 0   },
        { << l(1), 127>>, DateTime.from_unix! 127 },
      ],

      decode_errors: [
        {<<32>>,     {:invalid_date_value, <<32>>,
                       {:invalid_long, <<32>>,
                         {:invalid_short_length, <<32>>, 32}
                       }
                     } },

        {<<2, 32>>,  {:invalid_date_value, <<2, 32>>,
                       {:invalid_long, <<2, 32>>,
                         {:invalid_short_length, <<2, 32>>,
                           {:insufficient_bytes, 2}
                         }
                       }
                     } },
      ],

      encode_errors: [
        {DateTime.from_unix!(-1), {:invalid_date_value, DateTime.from_unix!(-1), :cannot_be_before_1970}},
      ]
end
