defmodule MMS.OkErrorTest do
  use ExUnit.Case

  import MMS.OkError
  import String

  describe "~> should pipe values and short circuit errors" do
    test "value ~> f => {:ok, f(value)}" do
      assert "x" ~> upcase == {:ok, "X"}
    end

    test "{:ok, value} ~>f => {:ok, f(value)}" do
      assert {:ok, "x"} ~> upcase == {:ok, "X"}
    end

    test "{:error, reason} ~f => {:error, reason}" do
      assert {:error, :reason} ~> upcase == {:error, :reason}
    end
  end

  describe "~>>" do
    test "value ~>> f => {:ok, value}" do
      assert "x" ~>> upcase == {:ok, "x"}
    end

    test "{:ok, value} ~>> f => {:ok, value}" do
      assert {:ok, "x"} ~>> upcase == {:ok, "x"}
    end

    test "{:error, reason} ~>> f => {:error f(reason)}" do
      assert {:error, "reason"} ~>> upcase == {:error, "REASON"}
    end
  end
end
