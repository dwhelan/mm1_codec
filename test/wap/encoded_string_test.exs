defmodule WAP.EncodedStringTest do

  alias WAP.EncodedString
  alias MM1.Result
  import EncodedString

  use MM1.CodecTest

  def bytes do
    <<"text", 0, "rest">>
  end

  def result do
    %Result{module: EncodedString, value: "text", bytes: <<"text", 0>>, rest: <<"rest">> }
  end

  describe "decode Text-string" do
    test "no terminator", do: assert %{value: {:err, :insufficient_bytes}, bytes: <<"text">>, rest: <<>> } = decode <<"text">>
  end

  describe "decode Value-length Char-set Text-string" do
    test "single byte charset", do: assert %{value: %{charset: :csUTF8, text: "text"}, bytes: <<3, 0xea, "text", 0>>, rest: <<"rest">>} = decode <<3, 0xea, "text", 0, "rest">>
#    test "no terminator", do: assert %{value: {:err, :insufficient_bytes}, bytes: <<"text">>, rest: <<>> } = decode <<"text">>
  end
end
