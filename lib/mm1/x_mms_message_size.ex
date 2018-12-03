defmodule MM1.XMmsMessageSize do
  use MM1.Header,
      value: 0x8e,
      codec: WAP.LongInteger
end
