defmodule WAP.TextStringTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.TextString

  examples TextString, [
    {"text", <<"text", 0>>, "text"},
  ]

  test "no terminator" do
    assert %{value: {:err, :missing_terminator}, bytes: <<>>, rest: <<"text">> } = TextString.decode <<"text">>
  end
end
