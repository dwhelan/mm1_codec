defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec

  @octet MM1.Headers.octet __MODULE__

  @message_types {
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

  def decode <<@octet, message_type, _::binary>> = bytes do
    value elem(@message_types, message_type - 128), 2, bytes
  end

  def encode result do
    result.bytes
  end
end
