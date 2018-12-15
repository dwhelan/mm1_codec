defmodule MM2.MessageTest do
  use ExUnit.Case

  use MM1.Codecs.TestExamples,
      codec: MM2.Message,
      examples: [
        {<<0x81, "x", 0, 0x81, "y", 0>>, {{MM2.Headers, [{MM2.Bcc, "x"}, {MM2.Bcc, "y"}]}, <<>>}},
      ]
end
