defmodule MMS.DataTypeTest do
  use ExUnit.Case
  import MMS.DataTypes

  describe "is_control_char: ensure" do
    test "0 is a control"       do assert is_control_char(0) end
    test "31 is a control"      do assert is_control_char(31) end
    test "32 is not a control"  do refute is_control_char(32) end
    test "126 is not a control" do refute is_control_char(126) end
    test "127 is a control"     do assert is_control_char(127) end
    test "128 is not a control" do refute is_control_char(128) end
    test "255 is not a control" do refute is_control_char(255) end
  end

  describe "is_separator_char: ensure" do
    test "'(' is a separator"     do assert is_separator_char(?() end
    test "')' is a separator"     do assert is_separator_char(?)) end
    test "'<' is a separator"     do assert is_separator_char(?<) end
    test "'>' is a separator"     do assert is_separator_char(?>) end
    test "'@' is a separator"     do assert is_separator_char(?@) end
    test "',' is a separator"     do assert is_separator_char(?,) end
    test "';' is a separator"     do assert is_separator_char(?;) end
    test "':' is a separator"     do assert is_separator_char(?:) end
    test "'\\' is a separator"    do assert is_separator_char(?\\) end
    test "'\"' is a separator"    do assert is_separator_char(?\") end
    test "'/' is a separator"     do assert is_separator_char(?/) end
    test "'[' is a separator"     do assert is_separator_char(?[) end
    test "']' is a separator"     do assert is_separator_char(?]) end
    test "'?' is a separator"     do assert is_separator_char(??) end
    test "'=' is a separator"     do assert is_separator_char(?=) end
    test "'{' is a separator"     do assert is_separator_char(?{) end
    test "'}' is a separator"     do assert is_separator_char(?}) end
    test "'space' is a separator" do assert is_separator_char(?\s) end
    test "'tab' is a separator"   do assert is_separator_char(?\t) end
  end

  describe "is_token_char: ensure" do
    test "33 is a token" do assert is_token_char(33) end
    test "126 is a token" do assert is_token_char(126) end
    test "control character is not a token" do refute is_token_char(0) end
    test "separator is not a token" do refute is_token_char(32) end
  end
end
