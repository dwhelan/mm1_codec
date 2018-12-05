defmodule MM1.CcTest do
  use ExUnit.Case

  alias MM1.Cc

  use MM1.Codecs.TestExamples, codec: Cc,
    examples: [
      {<<0x82, "abc", 0>>, "abc"}
    ]
end
