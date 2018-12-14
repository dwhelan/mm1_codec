defmodule MM1.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MM1.XMmsMessageSize

  use MM1.Codecs.TestExamples,
      codec: XMmsMessageSize,
      examples: [
        {<<0x8e, 1, 42>>, 42}
      ]
end

defmodule MM2.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MM2.XMmsMessageSize

  use MM1.Codecs2.TestExamples,
      codec: XMmsMessageSize,
      examples: [
        {<<1, 42>>, {42, ""}}
      ]
end

