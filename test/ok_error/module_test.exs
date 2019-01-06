defmodule OkError.ModuleTest do
  use ExUnit.Case

  import OkError.Module

  test "atom() should return module atom of caller" do
    assert atom() == :module_test
  end

  test "atom() should return module atom of caller" do
    assert atom() == :module_test
  end
end
