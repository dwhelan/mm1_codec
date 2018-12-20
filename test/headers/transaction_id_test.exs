defmodule MMS.TransactionIdTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.TransactionId,
      examples: [
        {<<"abc", 0>>, "abc"}
      ]
end
