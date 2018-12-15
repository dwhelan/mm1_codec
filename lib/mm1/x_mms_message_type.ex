defmodule MM2.XMmsMessageType do
  use MM1.Codecs2.Mapper,
      codec: WAP2.ShortInteger,
      values: [
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
