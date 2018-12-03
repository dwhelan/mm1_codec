defmodule MM1.Codecs.WrapperTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  use MM1.Codecs.Wrapper

  use MM1.Codecs.TestExamples,
      examples: [
        {<<0>>, %Result{module: Byte, value: 0, bytes: <<0>>}}
      ]

  def codec do
    Byte
  end
end
