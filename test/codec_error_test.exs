defmodule CodecErrorTest do
  use ExUnit.Case

  import CodecError

  describe "error name(module) macro should" do
    test "prepend 'invalid_' to module name" do
      assert error_name(ABC) == :abc
    end

    test "default to caller module" do
      assert error_name() == :codec_error_test
    end
  end

  describe "module_error/0" do
    test "reason should be underscore version of caller module" do
      assert module_error() == {:error, :codec_error_test}
    end
  end
end
