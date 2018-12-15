defmodule MM2.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MM2.XMmsMessageSize

  use MM1.Codecs2.TestExamples,
      codec: XMmsMessageSize,
      examples: [
        {<<1, 42>>, {42, ""}}
      ]
end

