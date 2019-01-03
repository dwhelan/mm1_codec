defmodule MMS.CodecTest do
  use ExUnit.Case

  import MMS.Codec

  test "prefix/2 should place byte at front of string" do
    assert prefix("ello world", ?h) == "hello world"
  end

  test "append/2 should append" do
    assert append("hello worl", "d") == "hello world"
  end
end
