defmodule MMS.MessageIdTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MessageId,
      examples: [
        {<<"@", 0>>, "@"}
      ]
end

