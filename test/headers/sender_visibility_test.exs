defmodule MMS.SenderVisibilityTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.SenderVisibility,

      examples: [
        { <<128>>, :hide },
        { <<129>>, :show },
      ],

      decode_errors: [
        { <<127>>, :invalid_sender_visibility },
        { <<130>>, :invalid_sender_visibility },
      ]
end

