defmodule WAP.ShortIntegerTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.ShortInteger, [
    {"min", <<128>>,   0},
    {"max", <<255>>, 127},
  ]
end
