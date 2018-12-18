defmodule MMS.ExpiryTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Expiry,
      examples: [
        {<<3, 128, 1, 0>>, {DateTime.from_unix!(0), 3}},
      ]
end

