defmodule OkError.MapTest do
  use ExUnit.Case

  import OkError.Map

  test "invert" do
    assert invert(%{a: 0, b: 1}) == %{0 => :a, 1 => :b}
  end

  test "from_list" do
    assert from_list([:a, :b]) == %{0 => :a, 1 => :b}
  end
end
