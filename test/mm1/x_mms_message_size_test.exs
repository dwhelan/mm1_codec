defmodule MM1.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MM1.XMmsMessageSize

  use MM1.Codecs.TestExamples, codec: XMmsMessageSize,
      examples: [
        {<<0x8e, 1, 42>>, 42}
      ]
end
