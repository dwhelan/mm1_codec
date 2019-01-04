defmodule MMS.OkErrorTest do
  use ExUnit.Case

  import MMS.OkError

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

  describe "if_ok should" do
    test "execute do clause for plain value" do
      assert if_ok("x", do: "X") == "X"
    end

    test "execute do clause for ok tuple" do
      assert if_ok({:ok, "x"}, do: "X") == "X"
    end

    test "not execute do clause for error tuple" do
      assert if_ok({:error, "x"}, do: "X") == nil
    end

    test "execute else clause for error tuple" do
      assert if_ok({:error, "x"}, do: "X", else: "Y") == "Y"
    end

    test "not execute clause for nil" do
      assert if_ok(nil, do: "X") == nil
    end

    test "execute else clause for nil" do
      assert if_ok(nil, do: "X", else: "Y") == "Y"
    end

    test "raise if option other than do or else" do
      assert_raise ArgumentError, fn ->
        Code.eval_string "import MMS.OkError; if_ok true, foo: 7"
      end
    end
  end

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

  describe "if_error should" do
    test "execute do clause for error tuple" do
      assert if_error({:error, "x"}, do: "X") == "X"
    end

    test "execute do clause for nil" do
      assert if_error(nil, do: "X") == "X"
    end

    test "not execute do clause for ok tuple" do
      assert if_error({:ok, "x"}, do: "X") == nil
    end

    test "execute else clause for ok tuple" do
      assert if_error({:ok, "x"}, do: "X", else: "Y") == "Y"
    end

    test "not execute do clause for plain value" do
      assert if_error("x", do: "X") == nil
    end

    test "execute else clause for plain value" do
      assert if_error("x", do: "X", else: "Y") == "Y"
    end

    test "raise if option other than do or else" do
      assert_raise ArgumentError, fn ->
        Code.eval_string "import MMS.OkError; if_error true, foo: 7"
      end
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
