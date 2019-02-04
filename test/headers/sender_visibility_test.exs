defmodule MMS.SenderVisibilityTest do
  import MMS.Test2

  use MMS.TestExamples,
      codec: MMS.SenderVisibility,

      examples: [
        { << s(0) >>, :hide },
        { << s(1) >>, :show },
      ],

      decode_errors: [
        { << s(-1)>>, :invalid_sender_visibility },
        { << s(2)>>,  :invalid_sender_visibility },
      ]
end

