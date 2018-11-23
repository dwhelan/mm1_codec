defmodule WAP.ByteTest do
  alias WAP.Byte
  alias MM1.Result
  import Byte

  use MM1.CodecTest

  def bytes do
    <<0, "rest">>
  end

  def result do
    %Result{module: Byte, value: 0, bytes: <<0>>, rest: <<"rest">>}
  end

  test "new" do
    assert Byte.new( -1) === %Result{module: Byte, value: 255, bytes: <<255>>, rest: <<>>}
    assert Byte.new(  0) === %Result{module: Byte, value:   0, bytes: <<  0>>, rest: <<>>}
    assert Byte.new(255) === %Result{module: Byte, value: 255, bytes: <<255>>, rest: <<>>}
    assert Byte.new(256) === %Result{module: Byte, value:   0, bytes: <<  0>>, rest: <<>>}
  end
end
