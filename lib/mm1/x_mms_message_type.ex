defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec

  def decode <<140, _::binary>> = bytes do
    value :m_send_req, 2, bytes
  end

  def encode value do
    <<140, value>>
  end
end
