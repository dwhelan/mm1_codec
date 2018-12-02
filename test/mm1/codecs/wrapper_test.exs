defmodule MM1.Codecs.WrapperTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  import MM1.Codecs.Wrapper

  use MM1.Codecs.BaseExamples,
      codec: __MODULE__,
      examples: [
        {<<0>>, %Result{module: Byte, value: 0, bytes: <<0>>}}
      ]

  def decode bytes do
    decode bytes, Byte, __MODULE__
  end

  def encode result do
    encode result, Byte, __MODULE__
  end

  def new value do
    new value, Byte, __MODULE__
  end

#  test "decode" do
#    bytes    = <<0, "rest">>
#    expected = %Result{module: __MODULE__, rest: "rest", value: Byte.decode(bytes)}
#
#    assert decode(bytes, Byte, __MODULE__) == expected
#  end
#
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
