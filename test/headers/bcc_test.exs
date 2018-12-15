defmodule MMS.BccTest do
  use ExUnit.Case

  alias MMS.Bcc

  use MMS.TestExamples,
      codec: Bcc,
      examples: [
        {<<"abc", 0>>, {"abc", <<>>}}
      ]
end

