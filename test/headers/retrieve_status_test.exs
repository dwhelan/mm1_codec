defmodule MMS.RetrieveStatusTest do
  import MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.RetrieveStatus,

      examples: [
        { << 128 >>, :ok                          },
        { << 192 >>, :transient_failure           },
        { << 193 >>, :transient_message_not_found },
        { << 194 >>, :transient_network_problem   },
        { << 224 >>, :permanent_failure           },
        { << 225 >>, :permanent_service_denied    },
        { << 226 >>, :permanent_message_not_found },
        { << 227 >>, :content_unsupported         },
      ],

      decode_errors: [
        { << 127 >>, {:retrieve_status, <<127>>, %{out_of_range: 127}} },
        { << 228 >>, {:retrieve_status, <<228>>, %{out_of_range: 228}} },
      ]
end
