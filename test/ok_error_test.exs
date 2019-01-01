defmodule MMS.OkErrorTest do
  use ExUnit.Case

  import MMS.OkError

  def upcase(string),  do: {:ok,    String.upcase string}
  def upcase!(reason), do: {:error, String.upcase reason}

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

  describe "either should" do
    test "return single function ok" do
      assert either("x", upcase) == {:ok, "X"}
    end

    test "return single function error" do
      assert either("x", upcase!) == {:error, "X"}
    end
  end

  describe "error/0" do
    test "reason should be underscore version of caller module" do
      assert error() == {:error, :invalid_ok_error_test}
    end
  end
end
