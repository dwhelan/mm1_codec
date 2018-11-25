defmodule WAP.ShortIntegerTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.ShortInteger

  examples ShortInteger, [
    {<<128>>,   0},
    {<<255>>, 127},
  ]

  test "decode(value < 128) should return an error" do
    assert ShortInteger.decode(<<127>>) === %Result{module: ShortInteger, value: 127, err: :value_must_be_less_than_128}
  end
end
