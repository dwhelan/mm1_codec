defmodule MM1.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MM1.XMmsMessageSize

  header_byte = XMmsMessageSize.header_byte()

  use MM1.CodecExamples, codec: XMmsMessageSize,
      examples: [
        {<<header_byte, 1, 42>>, 42}
      ]
end
