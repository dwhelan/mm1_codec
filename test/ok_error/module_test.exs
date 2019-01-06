defmodule OkError.ModuleTest do
  use ExUnit.Case

  import OkError.Module

  test "atom() macro should return module atom of caller" do
    assert atom() == :module_test
  end

  describe "atom(module) should" do
    test "return lower case atom" do
      assert atom(Kernel) == :kernel
    end

    test "only consider module part after last '.'" do
      assert atom(A.B.C) == :c
    end

    test "preserve acronyms" do
      assert atom(GDP) == :gdp
    end
  end
end
