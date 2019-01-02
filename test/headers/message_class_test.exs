defmodule MMS.MessageClassTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MessageClass,
      examples: [
        { <<128>>, :personal      },
        { <<129>>, :advertisement },
        { <<130>>, :informational },
        { <<131>>, :auto          },

        { <<"other\0">>, "other" },
      ],

      decode_errors: [
        { <<132>>, :invalid_message_class },
      ]
end

