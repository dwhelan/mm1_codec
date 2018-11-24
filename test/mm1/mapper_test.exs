defmodule MM1.MapperTest do
  use ExUnit.Case
  import MM1.Mapper

  build_mapper %{
    0 => "a",
    1 => "b",
  }

  test "map value" do
    assert map(0) === "a"
    assert map(1) === "b"
    assert map(2) === 2
  end

  test "map result" do
    assert map(result 0) === result "a"
    assert map(result 1) === result "b"
    assert map(result 2) === result 2
  end

  test "unmap" do
    assert unmap("a") === 0
    assert unmap("b") === 1
    assert unmap("c") === "c"
  end

  test "unmap result" do
    assert unmap(result "a") === result 0
    assert unmap(result "b") === result 1
    assert unmap(result "c") === result "c"
  end

  def result value do
    %MM1.Result{value: value}
  end
end
