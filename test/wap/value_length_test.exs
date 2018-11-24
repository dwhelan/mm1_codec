defmodule WAP.ValueLengthTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.ValueLength

  examples ValueLength, [
    {"0",  <<0>>,       0},
    {"30", <<30>>,     30},
    {"31", <<31, 31>>, 31},
    {"32", <<31, 32>>, 32},

    {"max uint32", <<31, 143, 255, 255, 255, 127>>, 0xffffffff},
  ]

  test "> 31 should not match", do: assert_raise FunctionClauseError, fn -> ValueLength.decode <<32>> end
end
