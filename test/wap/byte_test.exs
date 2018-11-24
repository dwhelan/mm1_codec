defmodule WAP.ByteTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.Byte, [
    {<<0>>,     0},
    {<<255>>, 255},
  ]

  test "new(positive) should be modulo 256" do
    assert WAP.Byte.new(256).bytes() === <<0>>
  end

  test "new(negative) should be modulo 256" do
    assert WAP.Byte.new(-1).bytes() === <<255>>
  end
end
