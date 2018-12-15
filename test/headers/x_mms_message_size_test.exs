defmodule MMS.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MMS.XMmsMessageSize

  use MM1.Codecs.TestExamples,
      codec: XMmsMessageSize,
      examples: [
        {<<1, 42>>, {42, ""}}
      ]
end

