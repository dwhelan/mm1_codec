defmodule MM1.OrdinalMapperTest do
  use ExUnit.Case
  import MM1.OrdinalMapper

  build_mapper [
    "a",
    "b",
  ]

  test "map" do
    assert map(0) === "a"
    assert map(1) === "b"
    assert map(2) === 2
  end

  test "unmap" do
    assert unmap("a") === 0
    assert unmap("b") === 1
    assert unmap("c") === "c"
  end
end
