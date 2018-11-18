defmodule MM1.MessageTest do
  use ExUnit.Case

  alias MM1.{Result, Message, Headers}
  import Message

  describe "decode" do
    test "should return a Result" do
      assert %Result{} = decode <<>>
    end

    test "module should be a Message" do
      assert %{module: Message} = decode <<>>
    end

    test "value should be a Headers Result" do
      headers_result = Headers.decode <<140, 0, 129, 0>>
      assert %{value: headers_result} = decode <<140, 0, 129, 0>>
    end

    test "rest should be a zero length binary" do
      assert %{rest: <<>>} = decode <<140, 0, 129, 0>>
    end
  end

  describe "encode" do
    test "encode" do
      assert <<0>> == encode 0
    end
  end
end
