defmodule WAP.UintvarTest do
  alias WAP.Uintvar
  alias MM1.Result
  import Uintvar

  use MM1.CodecTest

  def bytes do
    <<0, "rest">>
  end

  def result do
    %Result{module: Uintvar, value: 0, bytes: <<0>>, rest: <<"rest">>}
  end

  describe "encode" do
    test "one byte max",    do: assert decode(<<127>>).value === 127
    test "two bytes min",   do: assert decode(<<129, 0>>).value === 128
    test "two bytes max",   do: assert decode(<<255, 127>>).value === 16_383
    test "three bytes min", do: assert decode(<<129, 128, 0>>).value === 16_384
    test "three bytes max", do: assert decode(<<255, 255, 127>>).value === 2_097_151
    test "four bytes min",  do: assert decode(<<129, 128, 128, 0>>).value === 2_097_152
    test "four bytes max",  do: assert decode(<<255, 255, 255, 127>>).value === 268_435_455
    test "five bytes min",  do: assert decode(<<129, 128, 128, 128, 0>>).value === 268_435_456
    test "five bytes max",  do: assert decode(<<255, 255, 255, 255, 127>>).value === 34_359_738_367

    test "uint32 max", do: assert decode(<<143, 255, 255, 255, 127>>).value === 0xffffffff
  end
end
