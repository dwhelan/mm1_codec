defmodule MM1.MessageTest do
  use ExUnit.Case

  alias MM1.{Result, Message, Headers}
  import Message

  describe "decode" do
    test "should return a Result" do
      assert %Result{} = decode <<>>
    end

    test "module should be a Message" do
      assert %{module: Message} = decode <<>>
    end

    test "value should be a Headers Result" do
      result = decode <<140, 0, 129, 0>>
      headers_result = Headers.decode <<140, 0, 129, 0>>
      assert result.value == headers_result
    end

    test "rest should be a zero length binary" do
      assert %{rest: <<>>} = decode <<140, 0, 129, 0>>
    end
  end

  describe "encode" do
    test "encode" do
      result = encode %{
        module: Message,
        value: %{
          module: Headers,
          value: [
            %{module: MM1.XMmsMessageType, value: :m_send_req},
            %{module: MM1.Bcc,             value: 0}
          ]
        }
      }

      assert <<140, 0, 129, 0>> == result
    end
  end
end
