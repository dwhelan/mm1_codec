defmodule MM1.HeadersTest do
  use ExUnit.Case

  import MM1.Headers
  alias MM1.{Result, Headers, XMmsMessageType, Bcc}

  @bcc_bytes              <<octet(Bcc), 0>>
  @xms_message_type_bytes <<octet(XMmsMessageType), 0>>
  @bytes                  @xms_message_type_bytes <> @bcc_bytes

  describe "octet" do
    test "Bcc",             do: assert 129 == octet Bcc
    test "XMmsMessageType", do: assert 140 == octet XMmsMessageType
  end

  describe "decode" do
    test "should return a Headers Result" do
      assert %Result{module: Headers} = decode <<>>
    end

    test "Bcc" do
      assert %{value: [%{module: Bcc}]} = decode @bcc_bytes
    end

    test "XMmsMessageType" do
      assert %{value: [%{module: XMmsMessageType}]} = decode @xms_message_type_bytes
    end

    test "value should be an array of Headers" do
      assert %{
               value: [
                 %{module: XMmsMessageType},
                 %{module: Bcc},
               ]
             } = decode @bytes
    end
  end

  describe "encode" do
    test "Bcc" do
      headers = [%{module: Bcc, value: 0}]
      assert @bcc_bytes == encode %{module: Headers, value: headers}
    end

    test "XMmsMessageType" do
     headers = [%{module: XMmsMessageType, value: 0}]
      assert @xms_message_type_bytes == encode %{module: Headers, value: headers}
    end

    test "multiple headers" do
      headers = [%{module: XMmsMessageType, value: 0}, %{module: Bcc, value: 0}]
      assert @bytes == encode %{module: Headers, value: headers}
    end
  end
end
