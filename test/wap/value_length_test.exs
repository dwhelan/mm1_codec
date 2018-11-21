defmodule WAP.ValueLengthTest do
  alias WAP.ValueLength
  alias MM1.Result
  import ValueLength

  use MM1.CodecTest

  def bytes do
    <<0, "rest">>
  end

  def result do
    %Result{module: ValueLength, value: 0, bytes: <<0>>, rest: <<"rest">>}
  end

  describe "decode" do
    test "0..30 should be valid", do: assert decode(<<30>>).value === 30
    test "31 (length quote)",     do: assert decode(<<31, 31>>).value === 31
    test "> 31 should not match", do: assert_raise FunctionClauseError, fn -> decode <<32>> end
  end
end
