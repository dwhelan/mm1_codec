defmodule OldOkError.MapTest do
  use ExUnit.Case

  import Codec.Map

  test "invert" do
    assert invert_map(%{a: 0, b: 1}) == %{0 => :a, 1 => :b}
  end

  test "with_index" do
    assert with_index([:a, :b]) == %{0 => :a, 1 => :b}
  end
end
