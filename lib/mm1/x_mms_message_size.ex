defmodule MM1.XMmsMessageSize do
  use MM1.Header,
      value: 0x8e,
      codec: WAP.LongInteger
end

defmodule MM2.XMmsMessageSize do
  use MM2.Embed, codec: WAP2.LongInteger
end
