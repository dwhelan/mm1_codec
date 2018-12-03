defmodule MM1.XMmsMessageType do
  use MM1.Header,
      value: 0x8c,
      codec: WAP.ShortInteger,
      map: [
        :m_send_conf,
        :m_notification_ind,
        :m_notifyresp_ind,
        :m_send_req,
        :m_retrieve_conf,
        :m_acknowledge_ind,
        :m_delivery_ind,
        :m_read_rec_ind,
        :m_read_orig_ind,
        :m_forward_ind,
        :m_forward_conf,
      ]
end
