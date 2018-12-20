defmodule MMS.MessageTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Message,
      examples: [
        {<<0x81, "@", 0, 0x81, "@", 0>>, {MMS.Headers, [{MMS.Bcc, "@"}, {MMS.Bcc, "@"}]}},
      ]
end
