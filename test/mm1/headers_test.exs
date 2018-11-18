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
      headers = [%{module: Bcc, value: 0}]
      assert <<129, 0>> == encode %{module: Headers, value: headers}
    end

    test "XMmsMessageType" do
     headers = [%{module: XMmsMessageType, value: 0}]
      assert <<140, 0>> == encode %{module: Headers, value: headers}
    end

    test "multiple headers" do
      headers = [%{module: Bcc, value: 0}, %{module: XMmsMessageType, value: 0}]
      assert <<129, 0, 140, 0>> == encode %{module: Headers, value: headers}
    end
  end
end
