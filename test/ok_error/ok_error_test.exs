defmodule OkErrorTest do
  use ExUnit.Case

  import OkError

  def upcase(string),  do: {:ok,    String.upcase string}
  def upcase!(reason), do: {:error, String.upcase reason}

  describe "wrap/1 should" do
    test "preserve ok tuples" do
      assert wrap({:ok, "x"}) == {:ok, "x"}
    end

    test "preserve error tuples" do
      assert wrap({:error, "reason"}) == {:error, "reason"}
    end

    test "wrap plain values in ok tuple" do
      assert wrap("x") == {:ok, "x"}
    end

    test "wrap tuple values in ok tuple" do
      assert wrap({:tuple, "x"}) == {:ok, {:tuple, "x"}}
    end

    test "wrap nil as an error" do
      assert wrap(nil) == {:error, nil}
    end
  end

  describe "wrap_as_error\1 should" do
    test "preserve ok tuples" do
      assert wrap_as_error({:ok, "x"}) == {:ok, "x"}
    end

    test "preserve error tuples" do
      assert wrap_as_error({:error, "reason"}) == {:error, "reason"}
    end

    test "wrap plain values in error tuple" do
      assert wrap_as_error("x") == {:error, "x"}
    end

    test "wrap tuple values in error tuple" do
      assert wrap_as_error({:tuple, "x"}) == {:error, {:tuple, "x"}}
    end

    test "wrap nil as an error" do
      assert wrap_as_error(nil) == {:error, nil}
    end
  end

#  describe "if_ok should" do
#    test "execute do clause for plain value" do
#      assert if_ok("x", do: "X") == "X"
#    end
#
#    test "execute do clause for ok tuple" do
#      assert if_ok({:ok, "x"}, do: "X") == "X"
#    end
#
#    test "not execute do clause for error tuple" do
#      assert if_ok({:error, "x"}, do: "X") == nil
#    end
#
#    test "execute else clause for error tuple" do
#      assert if_ok({:error, "x"}, do: "X", else: "Y") == "Y"
#    end
#
#    test "not execute clause for nil" do
#      assert if_ok(nil, do: "X") == nil
#    end
#
#    test "execute else clause for nil" do
#      assert if_ok(nil, do: "X", else: "Y") == "Y"
#    end
#
#    test "raise if option other than do or else" do
#      assert_raise ArgumentError, fn ->
#        Code.eval_string "import OkError; if_ok true, foo: 7"
#      end
#    end
#  end

  describe "is_ok should be" do
    test "true for ok tuple" do
      assert is_ok({:ok, "x"}) == true
    end

    test "true for plain value" do
      assert is_ok("x") == true
    end

    test "false for error tuple" do
      assert is_ok({:error, "x"}) == false
    end

    test "false for nil" do
      assert is_ok(nil) == false
    end
  end

  describe "case_ok should" do
    test "execute case with input value if input is an ok tuple" do
      result = case_ok {:ok, "x"} do "x" -> "X" end
      assert result == "X"
    end

    test "execute case with input if input is a plain value" do
      result = case_ok "x" do "x" -> "X" end
      assert result == "X"
    end

    test "return input if input is an error tuple" do
      result = case_ok {:error, "x"} do "x" -> "X" end
      assert result == {:error, "x"}
    end

    test "return input if input is nil" do
      result = case_ok nil do "x" -> "X" end
      assert result == nil
    end
  end

  describe "case_error should" do
    test "return input if input is an ok tuple" do
      result = case_error {:ok, "x"} do "x" -> "X" end
      assert result == {:ok, "x"}
    end

    test "return input if input is a plain value" do
      result = case_error "x" do "x" -> "X" end
      assert result == "x"
    end

    test "execute case with error reason if input is an error tuple" do
      result = case_error {:error, "x"} do "x" -> "X" end
      assert result == "X"
    end

    test "execute case with nil if input is nil" do
      result = case_error nil do nil -> "X" end
      assert result == "X"
    end
  end

  describe "first_ok should" do
    test "should return first ok value" do
      assert first_ok([nil, "x", "y"], & &1) == ok "x"
    end

    test "should return last error if no ok values" do
      assert first_ok([nil, {:error, "x"}, {:error, "y"}], & &1) == error "y"
    end
  end

  describe "cons" do
    test "accepts plain values" do
      assert "x" |> cons("foo") == "foo"
    end

    test "accepts function" do
      assert "x" |> cons(String.upcase "y") == "Y"
    end
  end

  describe "~> should" do
    test "pipe ok values" do
      assert {:ok, "x"} ~> upcase == {:ok, "X"}
    end

    test "short circuit errors" do
      assert {:error, "reason"} ~> upcase == {:error, "reason"}
    end

    test "wrap inputs as values" do
      assert "x" ~> upcase == {:ok, "X"}
    end

    test "wrap outputs as values" do
      assert {:ok, "x"} ~> String.upcase == {:ok, "X"}
    end

    test "return errors from function" do
      assert {:ok, "x"} ~> upcase! == {:error, "X"}
    end
  end

  describe "~>> should" do
    test "pipe errors" do
      assert {:error, "reason"} ~>> upcase! == {:error, "REASON"}
    end

    test "short circuit ok values" do
      assert {:ok, "x"} ~>> upcase! == {:ok, "x"}
    end

    test "wrap inputs as values" do
      assert "x" ~>> upcase! == {:ok, "x"}
    end

    test "wrap outputs as errors" do
      assert {:error, "reason"} ~>> String.upcase == {:error, "REASON"}
    end

    test "return oks from function" do
      assert {:error, "reason"} ~>> upcase == {:ok, "REASON"}
    end
  end

  describe "error/0" do
    test "reason should be underscore version of caller module" do
      assert error() == {:error, :invalid_ok_error_test}
    end
  end
end
