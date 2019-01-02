defmodule MMS.StatusTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Status,

      examples: [
        { <<128>>, :expired       },
        { <<129>>, :retrieved     },
        { <<130>>, :rejected      },
        { <<131>>, :deferred      },
        { <<132>>, :unrecognized  },
        { <<133>>, :indeterminate },
        { <<134>>, :forwarded     },
      ],

      decode_errors: [
        { <<127>>, :invalid_status },
        { <<135>>, :invalid_status },
      ]
end
