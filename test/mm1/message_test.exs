defmodule MM1.MessageTest do
  use ExUnit.Case

  alias MM1.{Result, Message}
  import Message

  test "result should be an MMS Message" do
    assert %Result{module: Message} = decode <<>>
  end

  test "encode" do
    assert <<0>> == encode 0
  end
end
