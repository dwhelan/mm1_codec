defmodule MM1Test do
  use ExUnit.Case

  import MM1.Message

  alias MM1.{Message, Result, Error}

  describe "decode" do
    test "octet result" do
      octet_result = %Result{bytes: <<0>>, module: WAP.Octet,   rest: <<>>, value:   0}
      assert decode(<<0>>) === %Result{bytes: <<>>,  module: Message, rest: <<>>, value: octet_result}
    end

    test "octet error" do
      octet_error = %Error{bytes: <<>>, module: WAP.Octet, value: :insufficient_bytes}
      assert decode(<<>>) === %Error{bytes: <<>>,  module: Message, rest: <<>>, value: octet_error}
    end
  end
end
