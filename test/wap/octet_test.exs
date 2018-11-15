defmodule WAP.OctetTest do
  use ExUnit.Case

  import WAP.Octet

  alias MM1.Result

  test "octet" do
    assert decode(<<0>>)           === %Result{bytes: <<  0>>, value:   0, rest: <<>>,             module: WAP.Octet}
    assert decode(<<255, "rest">>) === %Result{bytes: <<255>>, value: 255, rest: <<"rest">>,       module: WAP.Octet}
    assert decode(<<>>)            === %Result{ bytes: <<>>,   value: {:err, :insufficient_bytes}, module: WAP.Octet}
  end
end
