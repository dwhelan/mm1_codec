defmodule MM1.XMmsMessageType do
#  use MM1.BaseCodec
#  import WAP.ShortIntegerMap

  use MM1.Header,
      codec: WAP.ShortInteger,
      mapper: WAP.ShortIntegerMap,
      values: {
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
      }

#  @header MM1.Headers.header_byte __MODULE__
#
#  @message_types {
#    :m_send_conf,
#    :m_notification_ind,
#    :m_notifyresp_ind,
#    :m_send_req,
#    :m_retrieve_conf,
#    :m_acknowledge_ind,
#    :m_delivery_ind,
#    :m_read_rec_ind,
#    :m_read_orig_ind,
#    :m_forward_ind,
#    :m_forward_conf,
#  }
#
#  def decode <<@header, message_type, rest::binary>> do
#    value map(message_type, @message_types), <<@header, message_type>>, rest
#  end
end
