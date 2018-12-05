defmodule MM1.BccTest do
  use ExUnit.Case

  alias MM1.Bcc

  use MM1.Codecs.TestExamples, codec: Bcc,
    examples: [
      {<<0x81, "abc", 0>>, "abc"}
    ]
end
