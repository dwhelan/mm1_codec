defmodule WAP.TextStringTest do
  use ExUnit.Case

  alias WAP.TextString
  alias MM1.Result

  import TextString

  describe "decode" do
    test "valid text",    do: assert decode(<<"text", 0, "rest">>) === %Result{module: TextString, value: "text", bytes: <<"text", 0>>, rest: <<"rest">> }

    test "no bytes",      do: assert %{value: {:err, :insufficient_bytes}, bytes: <<>>,       rest: <<>> } = decode <<>>
    test "no terminator", do: assert %{value: {:err, :insufficient_bytes}, bytes: <<"text">>, rest: <<>> } = decode <<"text">>
  end

#  describe "encode" do
#    test   "0", do: assert encode(%{bytes: <<  0>>}) === <<  0>>
#    test "255", do: assert encode(%{bytes: <<255>>}) === <<255>>
#  end
end
