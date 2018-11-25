defmodule MM1.CcTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias MM1.Cc

  examples Cc, [
    {<<Cc.header_byte(), "abc", 0>>, "abc"}
  ]
end
