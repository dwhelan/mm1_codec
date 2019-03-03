defmodule MMS.StatusTest do
  import MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Status,

      examples: [
        {<<128>>, :expired},
        {<<129>>, :retrieved},
        {<<130>>, :rejected},
        {<<131>>, :deferred},
        {<<132>>, :unrecognized},
        {<<133>>, :indeterminate},
        {<<134>>, :forwarded},
      ],

      decode_errors: [
        {<<127>>, {:status, <<127>>, %{out_of_range: 127}}},
        {<<135>>, {:status, <<135>>, %{out_of_range: 135}}},
      ],

      encode_errors: [
        {:x, {:status, :x, :out_of_range}},
      ]
end
