defmodule WAP.UintvarTest do
  alias WAP.Uintvar
  alias MM1.Result
  import Uintvar

  use MM1.CodecTest

  def bytes do
    <<0, "rest">>
  end

  def result do
    %Result{module: Uintvar, value: 0, bytes: <<0>>, rest: <<"rest">>}
  end

  describe "encode" do
    test "one byte" do
      assert decode(<<127>>).value === 127
    end
  end
end
