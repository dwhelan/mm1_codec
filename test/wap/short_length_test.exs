defmodule WAP.ShortLengthTest do
  alias WAP.ShortLength
  alias MM1.Result
  import ShortLength

  use MM1.CodecTest

  def bytes do
    <<0, "rest">>
  end

  def result do
    %Result{module: ShortLength, value: 0, bytes: <<0>>, rest: <<"rest">>}
  end

  describe "decode" do
    test "0..30 should be valid", do: assert decode(<<30>>).value === 30
    test "> 30 should not match", do: assert_raise FunctionClauseError,  fn -> decode <<31>> end
  end
end
