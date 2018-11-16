defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec

  def decode <<0x8c, 0x80, rest::binary>> do
    return %MM1.Result{bytes: <<0x8c, 0x80>>, value: :m_send_req, rest: rest}
  end
end
