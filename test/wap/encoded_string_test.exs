defmodule WAP.EncodedStringTest do

  alias WAP.EncodedString
  alias MM1.Result
  import EncodedString

  use MM1.CodecTest

  def bytes do
    <<6, 129, "text", 0, "rest">>
  end

  def result do
    %Result{module: EncodedString, value: %{charset: {:other, 1}, text: "text"}, bytes: <<6, 129, "text", 0>>, rest: <<"rest">> }
  end

  describe "decode" do
    test "no terminator", do: assert %{value: {:err, :insufficient_bytes}, bytes: <<"text">>, rest: <<>> } = decode <<"text">>
  end
end
