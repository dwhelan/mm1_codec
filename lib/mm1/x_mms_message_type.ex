defmodule WAP.ShortIntegerMap do

  def map(byte, values) when byte >= 128 and byte < 128 + tuple_size(values) do
    elem values, byte - 128
  end

  def map _, _ do
    :unknown
  end
end

defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec
  import WAP.ShortIntegerMap

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

  def decode <<@octet, message_type, rest::binary>> do
    value map(message_type, @message_types), <<@octet, message_type>>, rest
  end

  def encode result do
    result.bytes
  end
end
