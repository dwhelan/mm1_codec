defmodule WAP.ShortIntegerTest do
  alias WAP.ShortInteger
  alias MM1.Result
  import ShortInteger

  use MM1.CodecTest

  def bytes do
    <<128, "rest">>
  end

  def result do
    %Result{module: ShortInteger, value: 0, bytes: <<128>>, rest: <<"rest">>}
  end

  describe "decode" do
    test "<<255>> -> 127", do: assert decode(<<255>>).value === 127
  end
end
