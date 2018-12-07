#defmodule MM1.Codecs.WrapperTest do
#  use ExUnit.Case
#
#  alias WAP.Byte
#
#  use MM1.Codecs.Wrapper
#
#  use MM1.Codecs.TestExamples,
#      examples: [
#        {<<0>>, %MM1.Result{module: Byte, value: 0, bytes: <<0>>}}
#      ]
#
#  def codec do
#    Byte
#  end
#end

defmodule MM.Codecs2.WrapperTest do
  use ExUnit.Case

  alias WAP2.Byte

  use MM1.Codecs2.Wrapper

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<0>>, {0, Byte}},
      ]

  def codec do
    Byte
  end
end
