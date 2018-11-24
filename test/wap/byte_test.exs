defmodule WAP.ByteTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.Byte, [
    {<<0>>,     0},
    {<<255>>, 255},
  ]
end
