defmodule WAP.TextStringTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.TextString

  examples TextString, [
    {<<0>>, ""},
    {<<"text", 0>>, "text"},
  ]

  test "missing terminator" do
    assert TextString.decode(<<"text">>) ==
             %MM1.Result{
               module: TextString,
               value: "text",
               err: :missing_terminator,
               bytes: "text",
               rest: <<>>
             }
  end
end
