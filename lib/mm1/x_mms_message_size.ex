defmodule MM1.XMmsMessageSize do
  use MM1.Header,
      value: 0x8e,
      codec: WAP.LongInteger
end

defmodule MM2.XMmsMessageSize do
  alias WAP2.LongInteger

  defdelegate decode(bytes), to: LongInteger
  defdelegate encode(value), to: LongInteger
end
