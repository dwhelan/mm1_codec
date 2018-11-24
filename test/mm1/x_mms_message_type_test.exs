defmodule MM1.XMmsMessageTypeTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias MM1.XMmsMessageType

  examples XMmsMessageType, [
#    { <<XMmsMessageType.header_byte(), 128>>, :m_send_conf},
#    { <<XMmsMessageType.header_byte(), 129>>, :m_notification_ind},
#    { <<XMmsMessageType.header_byte(), 130>>, :m_notifyresp_ind},
#    { <<XMmsMessageType.header_byte(), 131>>, :m_send_req},
#    { <<XMmsMessageType.header_byte(), 132>>, :m_retrieve_conf},
#    { <<XMmsMessageType.header_byte(), 133>>, :m_acknowledge_ind},
#    { <<XMmsMessageType.header_byte(), 134>>, :m_delivery_ind},
#    { <<XMmsMessageType.header_byte(), 135>>, :m_read_rec_ind},
#    { <<XMmsMessageType.header_byte(), 136>>, :m_read_orig_ind},
#    { <<XMmsMessageType.header_byte(), 137>>, :m_forward_ind},
#    { <<XMmsMessageType.header_byte(), 138>>, :m_forward_conf},
#    { <<XMmsMessageType.header_byte(), 139>>, :unknown},
  ]

#  alias MM1.{Result, Headers, XMmsMessageType}
#  import XMmsMessageType
#
#  use MM1.CodecTest
#
#  def bytes(message_type \\ 128) do
#    <<Headers.header_byte(XMmsMessageType), message_type>>
#  end
#
#  def result do
#    %Result{module: XMmsMessageType, value: :m_send_conf, bytes: bytes()}
#  end
#
#  describe "decode" do
#    test "< 128",             do: assert decode(bytes 127).value === :unknown
#    test :m_send_conf,        do: assert decode(bytes 128).value === :m_send_conf
#    test :m_notification_ind, do: assert decode(bytes 129).value === :m_notification_ind
#    test :m_notifyresp_ind,   do: assert decode(bytes 130).value === :m_notifyresp_ind
#    test :m_send_req,         do: assert decode(bytes 131).value === :m_send_req
#    test :m_retrieve_conf,    do: assert decode(bytes 132).value === :m_retrieve_conf
#    test :m_acknowledge_ind,  do: assert decode(bytes 133).value === :m_acknowledge_ind
#    test :m_delivery_ind,     do: assert decode(bytes 134).value === :m_delivery_ind
#    test :m_read_rec_ind,     do: assert decode(bytes 135).value === :m_read_rec_ind
#    test :m_read_orig_ind,    do: assert decode(bytes 136).value === :m_read_orig_ind
#    test :m_forward_ind,      do: assert decode(bytes 137).value === :m_forward_ind
#    test :m_forward_conf,     do: assert decode(bytes 138).value === :m_forward_conf
#    test "> 138",             do: assert decode(bytes 139).value === :unknown
#  end
end
