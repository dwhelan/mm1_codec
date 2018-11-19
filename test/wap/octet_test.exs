defmodule WAP.OctetTest do
  use ExUnit.Case

  alias WAP.Octet
  alias MM1.Result

  import Octet

  describe "decode" do
    test "<<0>>",           do: assert decode(<<  0>>)         === %Result{module: Octet, value:   0, bytes: <<  0>>, rest: <<>>  }
    test "<<255>>",         do: assert decode(<<255>>)         === %Result{module: Octet, value: 255, bytes: <<255>>, rest: <<>>  }
    test "<<0, \"rest\">>", do: assert decode(<<  0, "rest">>) === %Result{module: Octet, value:   0, bytes: <<  0>>, rest: "rest"}

    test "<<>>", do: assert decode(<<>>) === %Result{module: Octet, value: {:err, :insufficient_bytes}, bytes: <<>>, rest: <<>> }
  end

  describe "encode" do
    test   "0", do: assert encode(%{bytes: <<  0>>}) === <<  0>>
    test "255", do: assert encode(%{bytes: <<255>>}) === <<255>>
  end
end
