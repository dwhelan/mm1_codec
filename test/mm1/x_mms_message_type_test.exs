defmodule MM1.XMmsMessageTypeTest do
  use ExUnit.Case

  alias MM1.XMmsMessageType

  use MM1.Codecs.TestExamples,
      codec: XMmsMessageType,
      examples: [
        {<<0x8c,  128>>, :m_send_conf       },
        {<<0x8c,  129>>, :m_notification_ind},
        {<<0x8c,  130>>, :m_notifyresp_ind  },
        {<<0x8c,  131>>, :m_send_req        },
        {<<0x8c,  132>>, :m_retrieve_conf   },
        {<<0x8c,  133>>, :m_acknowledge_ind },
        {<<0x8c,  134>>, :m_delivery_ind    },
        {<<0x8c,  135>>, :m_read_rec_ind    },
        {<<0x8c,  136>>, :m_read_orig_ind   },
        {<<0x8c,  137>>, :m_forward_ind     },
        {<<0x8c,  138>>, :m_forward_conf    },
        {<<0x8c,  139>>, 11                 },
      ]
end

defmodule MM2.XMmsMessageTypeTest do
  use ExUnit.Case

  alias MM2.XMmsMessageType

  use MM1.Codecs.TestExamples,
      codec: XMmsMessageType,
      examples: [
#        {<<128>>, :m_send_conf       },
#        {<<129>>, :m_notification_ind},
#        {<<130>>, :m_notifyresp_ind  },
#        {<<131>>, :m_send_req        },
#        {<<132>>, :m_retrieve_conf   },
#        {<<133>>, :m_acknowledge_ind },
#        {<<134>>, :m_delivery_ind    },
#        {<<135>>, :m_read_rec_ind    },
#        {<<136>>, :m_read_orig_ind   },
#        {<<137>>, :m_forward_ind     },
#        {<<138>>, :m_forward_conf    },
#        {<<139>>, 11                 },
      ]
end


