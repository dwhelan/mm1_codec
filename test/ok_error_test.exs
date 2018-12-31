defmodule MMS.OkErrorTest do
  use ExUnit.Case

  import MMS.OkError

  def upcase string do
    {:ok, String.upcase string}
  end

  describe "~> should" do
    test "pipe ok values" do
      assert {:ok, "x"} ~> upcase == {:ok, "X"}
    end

    test "short circuit errors" do
      assert {:error, :reason} ~> upcase == {:error, :reason}
    end

    test "wrap inputs" do
      assert "x" ~> upcase == {:ok, "X"}
    end

    test "wrap outputs" do
      assert {:ok, "x"} ~> String.upcase == {:ok, "X"}
    end
  end

  describe "~>> should" do
    test "pipe errors" do
      assert {:error, "reason"} ~>> String.upcase == {:error, "REASON"}
    end

    test "short circuit ok values" do
      assert {:ok, "x"} ~>> upcase == {:ok, "x"}
    end

    test "wrap inputs" do
      assert "x" ~>> upcase == {:ok, "x"}
    end

    test "wrap outputs" do
      assert "x" ~>> String.upcase == {:ok, "x"}
    end
  end
end
