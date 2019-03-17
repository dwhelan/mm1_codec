defmodule MMS.DataTypeTest do
  use ExUnit.Case
  import MMS.DataTypes

  describe "is_control: ensure" do
    test "0 is a control"       do assert is_control(0) end
    test "31 is a control"      do assert is_control(31) end
    test "32 is not a control"  do refute is_control(32) end
    test "126 is not a control" do refute is_control(126) end
    test "127 is a control"     do assert is_control(127) end
    test "128 is not a control" do refute is_control(128) end
    test "255 is not a control" do refute is_control(255) end
  end

  describe "is_separator: ensure" do
    test "'(' is a separator"     do assert is_separator(?() end
    test "')' is a separator"     do assert is_separator(?)) end
    test "'<' is a separator"     do assert is_separator(?<) end
    test "'>' is a separator"     do assert is_separator(?>) end
    test "'@' is a separator"     do assert is_separator(?@) end
    test "',' is a separator"     do assert is_separator(?,) end
    test "';' is a separator"     do assert is_separator(?;) end
    test "':' is a separator"     do assert is_separator(?:) end
    test "'\\' is a separator"    do assert is_separator(?\\) end
    test "'\"' is a separator"    do assert is_separator(?\") end
    test "'/' is a separator"     do assert is_separator(?/) end
    test "'[' is a separator"     do assert is_separator(?[) end
    test "']' is a separator"     do assert is_separator(?]) end
    test "'?' is a separator"     do assert is_separator(??) end
    test "'=' is a separator"     do assert is_separator(?=) end
    test "'{' is a separator"     do assert is_separator(?{) end
    test "'}' is a separator"     do assert is_separator(?}) end
    test "'space' is a separator" do assert is_separator(?\s) end
    test "'tab' is a separator"   do assert is_separator(?\t) end
  end

  describe "is_token: ensure" do
    test "33 is a token" do assert is_token(33) end
    test "126 is a token" do assert is_token(126) end
    test "control character is not a token" do refute is_token(0) end
    test "separator is not a token" do refute is_token(32) end
  end
end
