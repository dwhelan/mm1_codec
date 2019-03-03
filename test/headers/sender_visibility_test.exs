defmodule MMS.SenderVisibilityTest do
  import MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.SenderVisibility,

      examples: [
        {<<128>>, :hide},
        {<<129>>, :show},
      ],

      decode_errors: [
        {<<127>>, {:sender_visibility, <<127>>, %{out_of_range: 127}}},
        {<<130>>, {:sender_visibility, <<130>>, %{out_of_range: 130}}},
      ]
end

