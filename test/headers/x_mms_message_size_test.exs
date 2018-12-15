defmodule MMS.XMmsMessageSizeTest do
  use ExUnit.Case

  alias MMS.XMmsMessageSize

  use MMS.TestExamples,
      codec: XMmsMessageSize,
      examples: [
        {<<1, 42>>, {42, ""}}
      ]
end

