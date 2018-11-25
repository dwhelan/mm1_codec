defmodule MM1.MessageTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias MM1.{Result, Message}
  import Message

  examples Message, [
#    {<<>>, []}
  ]
end
