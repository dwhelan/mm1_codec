defmodule MMS.XMmsMessageSizeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.XMmsMessageSize,
      examples: [
        {<<1, 42>>, 42}
      ]
end

