defmodule MMS.CodecTest do
  use ExUnit.Case

  import MMS.Codec

  test "prefix/2 should place byte at front of string" do
    assert prefix("ello world", ?h) == "hello world"
  end

  test "suffix/2 should place byte at end of string" do
    assert suffix("hello worl", ?d) == "hello world"
  end
end
