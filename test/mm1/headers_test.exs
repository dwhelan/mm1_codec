defmodule MM1.HeadersTest do
  use ExUnit.Case

  import MM1.Headers
  alias MM1.{Result, Headers, XMmsMessageType, Bcc}

  describe "decode" do
    test "should return a Headers Result" do
      assert %Result{module: Headers} = decode <<>>
    end

    test "Bcc" do
      assert %{value: [%{module: Bcc}]} = decode <<129, 0>>
    end

    test "XMmsMessageType" do
      assert %{value: [%{module: XMmsMessageType}]} = decode <<140, 0>>
    end

    test "value should be an array of Headers" do
      assert %{
               value: [
                 %{module: XMmsMessageType},
                 %{module: Bcc},
               ]
             } = decode <<140, 128, 129, 0>>
    end
  end

  describe "encode" do
    test "Bcc" do
      assert <<129, 0>> == encode [%{module: Bcc, value: 0}]
    end

    test "XMmsMessageType" do
      assert <<140, 0>> == encode [%{module: XMmsMessageType, value: 0}]
    end

    test "multiple headers" do
      assert <<129, 0, 140, 0>> == encode [%{module: Bcc, value: 0}, %{module: XMmsMessageType, value: 0}]
    end
  end
end
