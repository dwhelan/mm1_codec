defmodule OldOkError.OperatorsTest do
  use ExUnit.Case

  import OldOkError
  import OldOkError.Operators

  test "~> should call when_ok" do
    assert {:ok, "x"} ~> String.upcase == {:ok, "X"}
  end

  test "~>> should call when_error" do
    assert {:error, "x"} ~>> String.upcase == {:error, "X"}
  end
end
