defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec
  alias MM1.Result

  def decode <<0x8c, 0x80, rest::binary>> do
    return %Result{bytes: <<0x8c, 0x80>>, value: :m_send_req, rest: rest}
  end
end
