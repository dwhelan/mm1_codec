defmodule MMS.CodecTest do
  use ExUnit.Case

  import MMS.Codec

  test "prepend/2" do
    assert prepend("ello world", "h") == "hello world"
  end

  test "append/2" do
    assert append("hello worl", "d") == "hello world"
  end
end
