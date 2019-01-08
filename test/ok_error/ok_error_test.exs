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

end
