defmodule MM1.WrapperCodeTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  use MM1.Codecs.Wrapper, codec: Byte

  test "decode" do
    bytes = <<0, "rest">>
    assert decode(bytes) == %Result{module: __MODULE__, rest: "rest", value: Byte.decode(bytes)}
  end

  test "encode" do
    result = Byte.new 0
    assert encode(%Result{module: __MODULE__, value: result}) == Byte.encode result
  end

  test "new" do
    assert new(0) == %Result{module: __MODULE__, value: Byte.new(0)}
  end
end
