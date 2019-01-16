defmodule OldOkError.ModuleTest do
  use ExUnit.Case

  import OldOkError.Module

  describe "name(module) macro should" do
    test "return lower case name" do
      assert name(A) == :a
    end

    test "only consider part after last '.'" do
      assert name(A.B.C) == :c
    end

    test "convert to underscore formay" do
      assert name(OkError) == :ok_error
    end

    test "keep consecutive upper case letters together" do
      assert name(ABc) == :abc
#      assert name(ABCd) == :abcd
    end

    test "merge other single letters with next part" do
      assert name(ProtocolIPv4) == :protocol_ipv4
    end

    test "default to caller module" do
      assert name() == :module_test
    end
  end

  describe "error name(module) macro should" do
    test "prepend 'invalid_' to module name" do
      assert error_name(ABC) == :invalid_abc
    end

    test "default to caller module" do
      assert error_name() == :invalid_module_test
    end
  end

  describe "module_error/0" do
    test "reason should be underscore version of caller module" do
      assert module_error() == {:error, :invalid_module_test}
    end
  end
end
