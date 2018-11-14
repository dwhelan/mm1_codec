defmodule MM1.Headers do
  alias MM1.{Result, Error}

  def decode <<octet, rest::binary>> do
    %Result{bytes: <<octet>>, value: octet, rest: rest, module: __MODULE__}
  end

  def decode <<>> do
    %Error{bytes: <<>>, value: :insufficient_bytes, module: __MODULE__}
  end

end

defmodule MM1Test do
  use ExUnit.Case

  import MM1.Message

  alias MM1.{Message, Result, Error, Headers}

  describe "decode" do
    test "m_send_req" do
      assert %Result{module: Message} = decode <<0>>
    end
  end
end

