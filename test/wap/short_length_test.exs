defmodule WAP.ShortLengthTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.ShortLength

  examples ShortLength, [
    {<< 0>>,  0},
    {<<30>>, 30},
  ]

  decode_errors ShortLength, [
    {<<31>>, :must_be_integer_less_than_31, 31},
  ]
end
