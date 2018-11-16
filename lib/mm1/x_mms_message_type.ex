defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec

  def decode <<0x8c, 0x80, _::binary>> = bytes do
    return :m_send_req, 2, bytes
  end
end
