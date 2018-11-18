defmodule MM1.MessageTest do
  use ExUnit.Case

  alias MM1.{Result, Message, Headers, HeadersTest}
  import Message

  def bytes do
    HeadersTest.bytes()
  end

  def result do
    %Result{
      module: Message,
      bytes:  <<>>,
      rest:   <<>>,
      value:  HeadersTest.result()
      }
  end

  test "decode" do
    assert decode(bytes()) === result()
  end

  test "encode" do
    assert encode(result()) === bytes()
  end
end
