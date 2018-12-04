defmodule MM1.Headers2Test do
  use ExUnit.Case
  alias MM1.{Result, Headers}
  alias MM1.{Bcc, Cc, XMmsMessageType, XMmsMessageSize}

  use MM1.Codecs.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81, "x", 0>>, [%Result{bytes: <<            Bcc.header_byte(), "x", 0>>, module: Bcc,             rest: "rest", value: "x"         }]},
        {<<0x82, "x", 0>>, [%Result{bytes: <<             Cc.header_byte(), "x", 0>>, module: Cc,              rest: "rest", value: "x"         }]},
        {<<0x8c,    128>>, [%Result{bytes: <<XMmsMessageType.header_byte(),    128>>, module: XMmsMessageType, rest: "rest", value: :m_send_conf}]},
        {<<0x8e,   1, 0>>, [%Result{bytes: <<XMmsMessageSize.header_byte(),   1, 0>>, module: XMmsMessageSize, rest: "rest", value:  0          }]},
      ]
end
