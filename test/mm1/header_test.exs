defmodule MM1.HeaderTest do
  use ExUnit.Case

  alias MM1.XMmsMessageSize

  use MM2.Header, codec: WAP2.ShortLength, byte: 0x80

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<0x80, 0>>, {{__MODULE__, 0}, <<>>}},
      ]
end
