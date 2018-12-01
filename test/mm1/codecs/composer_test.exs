defmodule MM1.Codecs.ComposerTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  import MM1.Codecs.Composer

  test "decode" do
    bytes    = <<0, 1, "rest">>
    expected = %Result{module: __MODULE__, bytes: <<0, 1>>, rest: "rest", value: [0, 1]}

    assert decode(bytes, Byte, Byte, __MODULE__) == expected
  end

#  test "encode" do
#    byte_result = Byte.new 0
#    result      = %Result{value: byte_result}
#    expected    = Byte.encode byte_result
#
#    assert encode(result, Byte, __MODULE__) == expected
#  end
#
#  test "new" do
#    value    = 0
#    expected = %Result{module: __MODULE__, value: Byte.new(value)}
#
#    assert new(value, Byte, __MODULE__) == expected
#  end
end
