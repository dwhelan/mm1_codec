defmodule MM1.BccTest do
  use ExUnit.Case

  import MM1.Bcc
  alias MM1.{Result, Bcc}

  describe "decode" do
    test "should return a Bcc" do
      assert %Result{module: Bcc, value: 0} = decode <<129, 0>>
    end
  end

#  describe "encode" do
#    @tag :skip
#    test "should encode Bcc" do
#      assert <<129, 0>> == encode 0
#    end
#  end
end
