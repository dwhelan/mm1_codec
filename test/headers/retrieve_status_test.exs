defmodule MMS.RetrieveStatusTest do
  import MMS.Test

  use MMS.TestExamples,
      codec: MMS.RetrieveStatus,

      examples: [
        { << s( 0) >>, :ok                          },
        { << s(64) >>, :transient_failure           },
        { << s(65) >>, :transient_message_not_found },
        { << s(66) >>, :transient_network_problem   },
        { << s(96) >>, :permanent_failure           },
        { << s(97) >>, :permanent_service_denied    },
        { << s(98) >>, :permanent_message_not_found },
        { << s(99) >>, :content_unsupported         },
      ],

      decode_errors: [
        { << s(-1) >>,  :invalid_retrieve_status },
        { << s(100) >>, :invalid_retrieve_status },
      ]
end
