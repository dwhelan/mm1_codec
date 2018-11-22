defmodule WAP.MultiOctetIntegerTest do
  alias WAP.MultiOctetInteger

  import MultiOctetInteger
  use MM1.CodecTest

  def bytes do
    <<1, 0, "rest">>
  end

  def result do
    %Result{module: MultiOctetInteger, value: 0, bytes: <<1, 0>>, rest: <<"rest">>}
  end

#  describe "decode" do
#    test "length = 0",         do: assert decode(<<>>,      0) === {:err, :length_cannot_be_zero}
#    test "length > 30",        do: assert decode(<<>>,     31) === {:err, :length_greater_than_30}
#    test "leading zeros",      do: assert decode(<<0, 0>>,  2) === {:err, :cannot_have_leading_zeros}
#    test "insufficient bytes", do: assert decode(<<>>,      1) === {:err, :insufficent_bytes}
#
#    test "0",      do: assert decode(<<0>>,        1) === {:ok, [WAP_MultiOctetInteger:      0], ""}
#    test "255",    do: assert decode(<<255>>,      1) === {:ok, [WAP_MultiOctetInteger:    255], ""}
#    test "256",    do: assert decode(<<1, 0>>,     2) === {:ok, [WAP_MultiOctetInteger:    256], ""}
#    test "65,535", do: assert decode(<<255, 255>>, 2) === {:ok, [WAP_MultiOctetInteger: 65_535], ""}
#
#    test "return rest", do: assert decode(<<0, "rest">>, 1) === {:ok, [WAP_MultiOctetInteger: 0], "rest"}
#  end
end
