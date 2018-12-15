defmodule MMS.BccTest do
  use ExUnit.Case

  alias MMS.Bcc

  use MM1.Codecs.TestExamples,
      codec: Bcc,
      examples: [
        {<<"abc", 0>>, {"abc", <<>>}}
      ]
end

