defmodule MM.Codecs2.Wrapper.WrapperTest do
  use ExUnit.Case

  alias WAP2.Byte

  import MM1.Codecs2.Wrapper
  wrap Byte

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<0>>, {0, Byte}},
      ]
end
