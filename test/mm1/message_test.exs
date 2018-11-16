defmodule MM1.MessageTest do
  use ExUnit.Case

  import MM1.Message

  alias MM1.{Result, Message}

  test "result should be an MMS Message" do
    assert %Result{module: Message} = decode <<>>
  end
end