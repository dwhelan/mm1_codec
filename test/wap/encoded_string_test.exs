defmodule WAP.EncodedStringTest do
  use ExUnit.Case

  alias WAP.EncodedString
  alias MM1.Result

  import EncodedString

  describe "decode" do
    test "unknown encoding", do: assert decode(<<3, 129, "text", 0, "rest">>) === %Result{module: EncodedString, value: %{charset: :other, text: "text"}, bytes: <<3, 129, "text", 0>>, rest: <<"rest">> }

    test "no bytes",      do: assert %{value: {:err, :insufficient_bytes}, bytes: <<>>,       rest: <<>> } = decode <<>>
    test "no terminator", do: assert %{value: {:err, :insufficient_bytes}, bytes: <<"text">>, rest: <<>> } = decode <<"text">>
  end

#  describe "encode" do
#    test   "0", do: assert encode(%{bytes: <<  0>>}) === <<  0>>
#    test "255", do: assert encode(%{bytes: <<255>>}) === <<255>>
#  end
end
