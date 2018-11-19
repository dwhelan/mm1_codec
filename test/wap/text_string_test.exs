defmodule WAP.TextStringTest do
  use ExUnit.Case

  alias WAP.TextString
  alias MM1.Result

  import TextString

  describe "decode" do
    test '<<"abc", 0>>',     do: assert decode(<<"abc", 0>>)     === %Result{module: TextString, value: "abc", bytes: <<"abc", 0>>, rest: <<>>  }
    test '<<"ab", 0, "c">>', do: assert decode(<<"ab", 0, "c">>) === %Result{module: TextString, value: "ab",  bytes: <<"ab",  0>>, rest: <<"c">>  }

#    test "<<>>", do: assert decode(<<>>) === %Result{module: Byte, value: {:err, :insufficient_bytes}, bytes: <<>>, rest: <<>> }
  end

#  describe "encode" do
#    test   "0", do: assert encode(%{bytes: <<  0>>}) === <<  0>>
#    test "255", do: assert encode(%{bytes: <<255>>}) === <<255>>
#  end
end
