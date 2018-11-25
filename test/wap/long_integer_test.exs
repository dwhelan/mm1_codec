defmodule WAP.LongIntegerTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.LongInteger

  examples LongInteger, [
    {<<1,   0>>,           0},
    {<<1, 255>>,         255},
    {<<2,   1,   0>>,    256},
    {<<2, 255, 255>>, 65_535},
    {
      <<30, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff::240>>,
      0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    }
  ]

  test "decode(length > 30) should return an error" do
    assert LongInteger.decode(<<31>>) === %Result{module: LongInteger, value: 31, err: :length_cannot_be_greater_than_30}
  end
end
