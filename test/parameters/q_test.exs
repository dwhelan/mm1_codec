defmodule MMS.QTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Q,
      examples: [
        {<<1>>,  "0.0"},
#        {<<2>>,  "0.1"},
      ]
end

