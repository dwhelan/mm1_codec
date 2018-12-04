defmodule MM1.Headers2Test do
  use ExUnit.Case
  alias MM1.{Result, Headers}
  alias MM1.{Bcc, Cc, XMmsMessageSize}

  use MM1.Codecs.TestExamples,
      codec: Headers,
      examples: [
        {<<            Bcc.header_byte(), "x", 0>>, [%Result{bytes: <<0x81, "x", 0>>, module: Bcc,             rest: "rest", value: "x"}]},
        {<<            Cc.header_byte(),  "x", 0>>, [%Result{bytes: <<0x82, "x", 0>>, module: Cc,              rest: "rest", value: "x"}]},
        {<<XMmsMessageSize.header_byte(),   1, 0>>, [%Result{bytes: <<0x8e,   1, 0>>, module: XMmsMessageSize, rest: "rest", value:   0}]},
      ]
end
