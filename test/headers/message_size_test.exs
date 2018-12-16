defmodule MMS.MessageSizeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MessageSize,
      examples: [
        {<<1, 42>>, 42}
      ]
end

