defmodule WAP.ByteTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.Byte, [
    {"one byte min", <<0>>,     0},
    {"one byte max", <<255>>, 255},
  ]
end
