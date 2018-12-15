defmodule MMS.MessageTest do
  use ExUnit.Case

  use MM1.Codecs.TestExamples,
      codec: MMS.Message,
      examples: [
        {<<0x81, "x", 0, 0x81, "y", 0>>, {{MMS.Headers, [{MMS.Bcc, "x"}, {MMS.Bcc, "y"}]}, <<>>}},
      ]
end
