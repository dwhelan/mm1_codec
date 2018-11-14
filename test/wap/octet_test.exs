defmodule WAP.OctetTest do
  use ExUnit.Case

  import WAP.Octet

  alias MM1.{Result, Error}

  test "octet" do
    assert %Result{bytes: <<  0>>, value:   0, rest: <<>>,       module: WAP.Octet} = decode <<0>>
    assert %Result{bytes: <<255>>, value: 255, rest: <<"rest">>, module: WAP.Octet} = decode <<255, "rest">>

    assert {:err, %Error{bytes: <<>>, reason: :insufficient_bytes, module: WAP.Octet}} = decode <<>>
  end
end
