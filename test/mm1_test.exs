defmodule Mm1CodecTest do
  use ExUnit.Case

  import MM1

  alias MM1.Result

  test "octet" do
    assert %Result{bytes: <<  0>>, value:   0, rest: <<>>,       module: MM1} = decode <<0>>
    assert %Result{bytes: <<255>>, value: 255, rest: <<"rest">>, module: MM1} = decode <<255, "rest">>

    assert {:err, :insufficient_bytes} = decode <<>>
  end
end
