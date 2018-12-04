defmodule MM1.Headers2Test do
  use ExUnit.Case
  alias MM1.{Result, Headers}
  alias MM1.{XMmsMessageSize}

  use MM1.Codecs.TestExamples,
      codec: Headers,
      examples: [
        {<<XMmsMessageSize.header_byte(), 1, 42>>, [%Result{bytes: <<142, 1, 42>>, module: XMmsMessageSize, rest: "rest", value: 42}]}
      ]
end
