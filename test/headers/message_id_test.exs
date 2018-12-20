defmodule MMS.MessageIDTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MessageID,
      examples: [
        {<<"@", 0>>, "@"}
      ]
end

