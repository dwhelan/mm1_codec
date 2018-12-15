defmodule MM2.BccTest do
  use ExUnit.Case

  alias MM2.Bcc

  use MM1.Codecs.TestExamples,
      codec: Bcc,
      examples: [
        {<<"abc", 0>>, {"abc", <<>>}}
      ]
end

