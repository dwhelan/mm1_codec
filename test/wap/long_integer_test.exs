defmodule WAP.LongIntegerTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.LongInteger, [
    {<<1,   0>>,           0},
    {<<1, 255>>,         255},
    {<<2,   1,   0>>,    256},
    {<<2, 255, 255>>, 65_535},
    {
      <<30, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff::240>>,
      0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    }
  ]
  test "decode length > 30 should not match", do: assert_raise FunctionClauseError, fn -> WAP.LongInteger.decode <<31>> end
end
