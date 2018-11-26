defmodule MM1.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MM1.XMmsMessageSize

  use MM1.CodecExamples, module: XMmsMessageSize,
      examples: [
        {<<XMmsMessageSize.header_byte(), 1, 42>>, 42}
      ]
end
