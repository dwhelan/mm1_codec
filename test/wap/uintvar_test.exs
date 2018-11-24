defmodule WAP.UintvarTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.Uintvar, [
    {"one byte min",    <<0>>, 0},
    {"one byte max",    <<127>>, 127},
    {"two bytes min",   <<129, 0>>, 128},
    {"two bytes max",   <<255, 127>>, 16_383},
    {"three bytes min", <<129, 128, 0>>, 16_384},
    {"three bytes max", <<255, 255, 127>>, 2_097_151},
    {"four bytes min",  <<129, 128, 128, 0>>, 2_097_152},
    {"four bytes max",  <<255, 255, 255, 127>>, 268_435_455},
    {"five bytes min",  <<129, 128, 128, 128, 0>>, 268_435_456},
    {"five bytes max",  <<255, 255, 255, 255, 127>>, 34_359_738_367},
  ]
end
