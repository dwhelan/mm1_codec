defmodule MM1.XMmsMessageSizeTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias MM1.XMmsMessageSize

  examples XMmsMessageSize, [
    {<<XMmsMessageSize.header_byte(), 1, 42>>, 42}
  ]
end
