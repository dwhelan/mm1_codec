defmodule MM1.HeadersTest do
  use ExUnit.Case

  import MM1.Headers
  alias MM1.{Result, Headers}
  alias MM1.{Bcc, BccTest}

  describe "octet" do
    test "Bcc",             do: assert 129 == octet Bcc
    test "XMmsMessageType", do: assert 140 == octet XMmsMessageType
  end

  describe "decode" do
    test "module should be Headers" do
      assert decode(<<>>).module == Headers
    end

    test "bytes should be <<>>" do
      assert decode(<<>>).bytes == <<>>
      assert decode(BccTest.bytes).bytes == <<>>
    end

    test "value with one header" do
      assert decode(BccTest.bytes).value == [BccTest.result]
    end

    test "value with multiple headers" do
      [bcc1, bcc2] = decode(BccTest.bytes <> BccTest.bytes).value
      assert bcc1 == %Result{BccTest.result | rest: BccTest.bytes()}
      assert bcc2 == BccTest.result
    end
  end

  describe "encode" do
    test "one header" do
      assert encode(%{value: [BccTest.result]}) == BccTest.bytes
    end

    test "multiple headers" do
      assert encode(%{module: Headers, value: [BccTest.result, BccTest.result]}) == BccTest.bytes() <> BccTest.bytes()
    end
  end
end
