defmodule WAP.ByteTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.Byte

  examples Byte, [
    {<<0>>,     0},
    {<<255>>, 255},
  ]

  new_errors Byte, [
    {  -1, :must_be_an_integer_between_0_and_255},
    { 256, :must_be_an_integer_between_0_and_255},
    {1.23, :must_be_an_integer_between_0_and_255},
    {:foo, :must_be_an_integer_between_0_and_255},
  ]
end
