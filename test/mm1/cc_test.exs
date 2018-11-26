defmodule MM1.CcTest do
  use ExUnit.Case

  alias MM1.Cc

  use MM1.CodecExamples, codec: Cc,
    examples: [
      {<<Cc.header_byte(), "abc", 0>>, "abc"}
    ]
end
