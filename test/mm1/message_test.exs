defmodule MM1.MessageTest do
  use ExUnit.Case

  alias MM1.{Result, Message, HeadersTest}
  import Message
  use MM1.CodecTest

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
end
