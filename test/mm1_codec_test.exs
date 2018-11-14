defmodule Mm1CodecTest do
  use ExUnit.Case

  import Mm1Codec

  alias Mm1.Result

  test "octet" do
    assert %Result{bytes: <<  0>>, value:   0, rest: <<>>,       module: Mm1Codec} = decode <<0>>
    assert %Result{bytes: <<255>>, value: 255, rest: <<"rest">>, module: Mm1Codec} = decode <<255, "rest">>

    assert {:err, :insufficient_bytes} = decode <<>>
  end
end
