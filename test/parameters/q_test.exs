defmodule MMS.QTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Q,
      examples: [
        {<<1>>,   0.0},
        {<<2>>,   0.01},
        {<<3>>,   0.02},
        {<<11>>,  0.1},
        {<<100>>, 0.99},
      ]
end

