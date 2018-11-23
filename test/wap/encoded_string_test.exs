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
    test "no terminator", do: assert %{value: {:err, :missing_terminator}, bytes: <<"text">>, rest: <<>> } = decode <<"text">>
  end

  describe "decode Value-length Char-set Text-string" do
    test "short Value-length" do
      assert %{value: {6, _, _} } = decode <<6, 0xea, "text", 0>>
    end

    test "long Value-length" do
      assert %{value: {42, _, _} } = decode <<31, 42, 0xea, "text", 0>>
    end

    test "short Char-set" do
      assert %{value: {_, :csUTF8, _}} = decode <<6, 0xea, "text">>
    end

    test "long Char-set" do
      assert %{value: {_, :csUnicode, _}, } = decode <<8, 2, 0x03, 0xe8, "text", 0>>
    end
  end
end
