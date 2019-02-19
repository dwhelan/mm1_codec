defmodule MMS.SenderVisibilityTest do
  import MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.SenderVisibility,

      examples: [
        { << s(0) >>, :hide },
        { << s(1) >>, :show },
      ],

      decode_errors: [
        { << s(-1)>>, :sender_visibility },
        { << s(2)>>,  :sender_visibility },
      ]
end

