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
end
