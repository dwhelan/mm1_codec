defmodule MMS.BccTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Bcc,
      examples: [
        {<<"@", 0>>, "@"}
      ]
end

