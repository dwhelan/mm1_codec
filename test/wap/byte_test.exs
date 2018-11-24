defmodule WAP.ByteTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.Byte, [
    {<<0>>,     0},
    {<<255>>, 255},
  ]

  test "should wrap numbers > 255" do
    assert WAP.Byte.new(256).bytes() === <<0>>
  end

  test "should wrap numbers < 0" do
    assert WAP.Byte.new(-1).bytes() === <<255>>
  end
end
