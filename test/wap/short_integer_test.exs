defmodule WAP.ShortIntegerTest do
  use ExUnit.Case
  import MM1.CodecExamples

  examples WAP.ShortInteger, [
    {<<128>>,   0},
    {<<255>>, 127},
  ]
end
