defmodule MMS.BccTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Bcc,
      examples: [
        {<<"abc", 0>>, "abc"}
      ]
end

