defmodule OkError.ModuleTest do
  use ExUnit.Case

  import OkError.Module

  describe "atom(module) macro should" do
    test "return lower case atom" do
      assert atom(ABC) == :abc
    end

    test "only consider module part after last '.'" do
      assert atom(A.B.C) == :c
    end

    test "convert to underscore formar" do
      assert atom(OkError) == :ok_error
    end

    test "merge initial single letter with next part" do
      assert atom(IPv4) == :ipv4
    end

    test "merge other single letters with next part" do
      assert atom(ProtocolIPv4) == :protocol_ipv4
    end

    test "default to caller module" do
      assert atom() == :module_test
    end
  end

  describe "error atom(module) macro should" do
    test "prepend 'invalid_' to module atom" do
      assert error_atom(ABC) == :invalid_abc
    end

    test "default to caller module" do
      assert error_atom() == :invalid_module_test
    end
  end
end
