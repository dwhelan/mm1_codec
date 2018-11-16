defmodule MM1.Bcc do
  use MM1.BaseCodec
  alias MM1.Result

  def decode <<0x8c, 0x81, rest::binary>> do
    return %Result{bytes: <<0x8c, 0x81>>, value: 0x81, rest: rest}
  end
end

defmodule MM1.XMmsMessageType do
  use MM1.BaseCodec
  alias MM1.Result

  def decode <<0x8c, 0x80, rest::binary>> do
    return %Result{bytes: <<0x8c, 0x80>>, value: :m_send_req, rest: rest}
  end
end

defmodule MM1.Headers do
  require WAP.Octet

  use MM1.BaseCodec
  alias MM1.Result

  def decode bytes do
    values = []
    h1 = %Result{rest: rest} = MM1.XMmsMessageType.decode(bytes)
    h2 = %Result{rest: rest} = MM1.Bcc.decode(rest)

    return %Result{value: [
      h1, h2
    ]}
  end
end
