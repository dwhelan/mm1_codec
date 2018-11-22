defmodule WAP.LongIntegerTest do
  alias WAP.LongInteger

  import LongInteger
  use MM1.CodecTest

  def bytes do
    <<1, 0, "rest">>
  end

  def result do
    %Result{module: LongInteger, value: 0, bytes: <<1, 0>>, rest: <<"rest">>}
  end

  describe "decode" do
    test "one byte max", do: assert decode(<<1, 255>>).value === 255
    test "two byte min", do: assert decode(<<2, 1, 0>>).value === 256
    test "two byte max", do: assert decode(<<1, 255>>).value === 255

    test "thirty byte max", do: assert decode(<<30, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff::240>>).value === 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  end
end
