defmodule MMS.CcTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Cc,
      examples: [
        {<<"abc", 0>>, "abc"}
      ]
end