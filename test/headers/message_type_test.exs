defmodule MMS.MessageTypeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MessageType,
      examples: [
        {<<128>>, :m_send_req        },
        {<<129>>, :m_send_conf       },
        {<<130>>, :m_notification_ind},
        {<<131>>, :m_notifyresp_ind  },
        {<<132>>, :m_retrieve_conf   },
        {<<133>>, :m_acknowledge_ind },
        {<<134>>, :m_delivery_ind    },
        {<<135>>, :m_read_rec_ind    },
        {<<136>>, :m_read_orig_ind   },
        {<<137>>, :m_forward_ind     },
        {<<138>>, :m_forward_conf    },
      ],

      decode_errors: [
        { <<139>>, {:message_type, <<139>>, %{out_of_range: 139}} },
      ]
end
