defmodule MMS.StatusTest do
  import MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Status,

      examples: [
        { << s(0) >>, :expired       },
        { << s(1) >>, :retrieved     },
        { << s(2) >>, :rejected      },
        { << s(3) >>, :deferred      },
        { << s(4) >>, :unrecognized  },
        { << s(5) >>, :indeterminate },
        { << s(6) >>, :forwarded     },
      ],

      decode_errors: [
        { << s(-1) >>, :status },
        { << s(7)  >>, :status },
      ],

      encode_errors: [
        { :x, :status},
      ]
end
