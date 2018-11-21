defmodule WAP.ShortLengthTest do
  alias WAP.ShortLength
  alias MM1.Result
  import ShortLength

  use MM1.CodecTest

  def bytes do
    <<0, "rest">>
  end

  def result do
    %Result{module: ShortLength, value: 0, bytes: <<0>>, rest: <<"rest">>}
  end
end
