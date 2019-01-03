defmodule MMS.CodecTest do
  use ExUnit.Case

  import MMS.Codec

  describe "prefix/2 should" do
    test "prefix byte at front of string" do
      assert prefix("ello world", ?h) == "hello world"
    end
  end
end
