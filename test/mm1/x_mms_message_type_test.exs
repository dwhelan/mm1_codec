defmodule MM1.XMmsMessageTypeTest do
  use ExUnit.Case

  alias MM1.XMmsMessageType

  header_byte = XMmsMessageType.header_byte()

  use MM1.Codecs.BaseExamples, codec: XMmsMessageType,
      examples: [
        {<<header_byte, 128>>, :m_send_conf},
        {<<header_byte, 129>>, :m_notification_ind},
        {<<header_byte, 130>>, :m_notifyresp_ind},
        {<<header_byte, 131>>, :m_send_req},
        {<<header_byte, 132>>, :m_retrieve_conf},
        {<<header_byte, 133>>, :m_acknowledge_ind},
        {<<header_byte, 134>>, :m_delivery_ind},
        {<<header_byte, 135>>, :m_read_rec_ind},
        {<<header_byte, 136>>, :m_read_orig_ind},
        {<<header_byte, 137>>, :m_forward_ind},
        {<<header_byte, 138>>, :m_forward_conf},
        {<<header_byte, 139>>, 11},
      ]
end
