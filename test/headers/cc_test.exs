defmodule MMS.CcTest do
  use ExUnit.Case

  alias MMS.Cc

  use MM1.Codecs.TestExamples,
      codec: Cc,
      examples: [
        {<<"abc", 0>>, {"abc", <<>>}}
      ]
end
