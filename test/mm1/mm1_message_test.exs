defmodule MM1Test do
  use ExUnit.Case

  import MM1.Message

  alias MM1.Result

  describe "decode" do
    test "octet" do
      octet_result = %Result{bytes: <<0>>, module: WAP.Octet,   rest: <<>>, value:   0}
      assert decode(<<0>>) === %Result{bytes: <<>>,  module: MM1.Message, rest: <<>>, value: octet_result}

#      assert decode(<<>>) === %Result{bytes: <<>>,  module: MM1.Message, rest: <<>>, value: octet_result}
    end
  end
end
