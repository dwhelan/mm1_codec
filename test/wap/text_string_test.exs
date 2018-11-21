defmodule WAP.TextStringTest do
  alias WAP.TextString
  alias MM1.Result
  import TextString

  use MM1.CodecTest

  def bytes do
    <<"text", 0, "rest">>
  end

  def result do
    %Result{module: TextString, value: "text", bytes: <<"text", 0>>, rest: <<"rest">> }
  end

  describe "decode" do
    test "no terminator", do: assert %{value: {:err, :insufficient_bytes}, bytes: <<"text">>, rest: <<>> } = decode <<"text">>
  end
end
