defmodule MMS.DateTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Date,
      examples: [
        {<<1, 0>>, 0}
      ]
end

