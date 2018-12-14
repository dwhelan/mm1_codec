defmodule MM1.XMmsMessageSize do
  use MM1.Header,
      value: 0x8e,
      codec: WAP.LongInteger
end

defmodule MM2.XMmsMessageSize do
  alias WAP2.LongInteger

  def decode bytes do
    bytes |> LongInteger.decode
  end

  def encode value do
    value |> LongInteger.encode
  end
end
