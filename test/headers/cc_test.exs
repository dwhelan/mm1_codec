defmodule MMS.CcTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Cc,
      examples: [
        {<<"@", 0>>, "@"}
      ]
end
