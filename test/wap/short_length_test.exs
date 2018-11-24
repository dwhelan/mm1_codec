defmodule WAP.ShortLengthTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.ShortLength

  examples ShortLength, [
    {<< 0>>,  0},
    {<<30>>, 30},
  ]

  test "decode value > 30 should not match", do: assert_raise FunctionClauseError,  fn -> ShortLength.decode <<31>> end
end
