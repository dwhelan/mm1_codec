defmodule MM1.BccTest do
  use ExUnit.Case

  alias MM1.{Result, Bcc}
  import Bcc

  describe "decode" do
    test "should decode" do
      assert %Result{module: Bcc, value: 0, bytes: <<129, 0>>, rest: <<"rest">> } = decode <<129, 0, "rest">>
    end
  end

  describe "encode" do
    test "should encode" do
      assert <<129, 0>> == encode 0
    end
  end
end
