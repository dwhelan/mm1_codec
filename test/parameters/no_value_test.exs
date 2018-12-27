defmodule MMS.NoValueTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.NoValue,
      examples: [
        # single byte: 2 decimal places
        {<<0>>,   :no_value},
      ]
end

