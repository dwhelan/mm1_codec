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

  describe "when_ok/2 should" do
    test "pipe ok values" do
      assert {:ok, "x"} |> when_ok(upcase) == {:ok, "X"}
    end

    test "short circuit errors" do
      assert {:error, "reason"} |> when_ok(upcase) == {:error, "reason"}
    end

    test "wrap inputs as values" do
      assert "x" |> when_ok(upcase) == {:ok, "X"}
    end

    test "wrap outputs as values" do
      assert {:ok, "x"} |> when_ok(String.upcase) == {:ok, "X"}
    end

    test "return errors from function" do
      assert {:ok, "x"} |> when_ok(upcase!) == {:error, "X"}
    end
  end

  describe "when_error/2 should" do
    test "pipe errors" do
      assert {:error, "x"} |> when_error(upcase!) == {:error, "X"}
    end

    test "short circuit ok values" do
      assert {:ok, "x"} |> when_error(upcase!) == {:ok, "x"}
    end

    test "wrap inputs as values" do
      assert "x" |> when_error(upcase!) == {:ok, "x"}
    end

    test "wrap outputs as errors" do
      assert {:error, "x"} |> when_error(String.upcase) == {:error, "X"}
    end

    test "return oks from function" do
      assert {:error, "x"} |> when_error(upcase) == {:ok, "X"}
    end
  end

end
