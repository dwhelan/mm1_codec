defmodule MMS.ReplyChargingTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ReplyCharging,

      examples: [
        { <<128>>, :requested           },
        { <<129>>, :requested_text_only },
        { <<130>>, :accepted            },
        { <<131>>, :accepted_text_only  },
      ],

      decode_errors: [
        { <<127>>, :reply_charging },
        { <<132>>, :reply_charging },
      ]
end
