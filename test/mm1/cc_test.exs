defmodule MM2.CcTest do
  use ExUnit.Case

  alias MM2.Cc

  use MM1.Codecs.TestExamples,
      codec: Cc,
      examples: [
        {<<"abc", 0>>, {"abc", <<>>}}
      ]
end
