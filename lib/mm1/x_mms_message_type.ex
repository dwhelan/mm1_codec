defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec

  @octet MM1.Headers.octet __MODULE__

  def decode <<@octet, _::binary>> = bytes do
    value :m_send_req, 2, bytes
  end

  def encode result do
    result.bytes
  end
end
