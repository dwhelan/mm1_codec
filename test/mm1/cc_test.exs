defmodule MM1.CcTest do
  use ExUnit.Case

  alias MM1.Cc

  header_byte = Cc.header_byte()

  use MM1.BaseDecoderExamples, codec: Cc,
    examples: [
      {<<header_byte, "abc", 0>>, "abc"}
    ]
end
