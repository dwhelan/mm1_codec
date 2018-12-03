defmodule MM1.XMmsMessageType.Codec do
  alias MM1.Codecs.Mapper

  use Mapper,
      codec: WAP.ShortInteger,
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

defmodule MM1.XMmsMessageType do
  use MM1.Header, codec: MM1.XMmsMessageType.Codec
end
