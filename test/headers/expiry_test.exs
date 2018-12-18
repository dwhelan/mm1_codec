defmodule MMS.ExpiryTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Expiry,
      examples: [
        {<<3, 129, 1, 0>>, 0},
      ]
end

