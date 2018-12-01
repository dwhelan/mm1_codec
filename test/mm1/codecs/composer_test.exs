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

  test "encode" do
    result = %Result{module: __MODULE__, bytes: <<0, 1>>, rest: "rest", value: [0, 1]}

    assert encode(result, Byte, Byte, __MODULE__) == <<0, 1>>
  end

  test "new" do
    value    = [0, 1]
    expected = %Result{module: __MODULE__, bytes: <<0, 1>>, value: value}

    assert new(value, Byte, Byte, __MODULE__) == expected
  end
end
