defmodule MMS.MessageTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Message,
      examples: [
        {<<129, "@", 0, 129, "@", 0>>, {MMS.Headers, [bcc: {"@", :email}, bcc: {"@", :email}]}},
      ]
end
