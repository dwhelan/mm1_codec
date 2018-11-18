defmodule MM1.XMmsMessageTypeTest do
  use ExUnit.Case

  alias MM1.{Result, Headers, XMmsMessageType}
  import XMmsMessageType

  def bytes do
    <<Headers.octet XMmsMessageType>> <> <<0>>
  end

  def result do
    %Result{module: XMmsMessageType, value: :m_send_req, bytes: bytes()}
  end

  describe "decode" do
    test "bytes" do
      assert decode(bytes() <> <<"rest">>) == %Result{result() | rest: <<"rest">>}
    end
  end

  describe "encode" do
    test "result" do
      assert encode(result()) == bytes()
    end
  end
end
