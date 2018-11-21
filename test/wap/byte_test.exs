defmodule WAP.ByteTest do
  alias WAP.Byte
  alias MM1.Result
  import Byte

  use MM1.CodecTest

  def bytes do
    <<0>>
  end

  def result do
    %Result{module: Byte, value: 0, bytes: <<  0>>, rest: <<>> }
  end

  describe "decode" do
    test "<<255>>", do: assert decode(<<255>>)               === %Result{module: Byte, value: 255, bytes: <<255>>, rest: <<>>  }
    test "rest",    do: assert decode(bytes() <> <<"rest">>) === %Result{result() | rest: "rest"}
  end

  describe "encode" do
    test "255", do: assert encode(%{bytes: <<255>>}) === <<255>>
  end
end
