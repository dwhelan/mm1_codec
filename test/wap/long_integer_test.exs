defmodule WAP.LongIntegerTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.LongInteger, [
    {"one byte min", <<1,   0>>,           0},
    {"one byte max", <<1, 255>>,         255},
    {"two byte min", <<2,   1,   0>>,    256},
    {"two byte max", <<2, 255, 255>>, 65_535},
    {
      "thirty byte max",
      <<30, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff::240>>,
      0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    }
  ]
end
