defmodule MMS.CcTest do
  use ExUnit.Case

  alias MMS.Cc

  use MMS.TestExamples,
      codec: Cc,
      examples: [
        {<<"abc", 0>>, {"abc", <<>>}}
      ]
end
