defmodule MM1.HeadersTest do
  use ExUnit.Case

  import MM1.Headers
  alias MM1.{Result, Headers}
  alias MM1.{Bcc, BccTest}

  def bytes do
    BccTest.bytes() <> BccTest.bytes()
  end

  def result do
    %Result{
      module: Headers,
      bytes:  <<>>,
      rest:   <<>>,
      value:  [
        %Result{BccTest.result | rest: BccTest.bytes()},
        BccTest.result()
      ]}
  end

  describe "octet" do
    test "Bcc",             do: assert 129 == octet Bcc
    test "XMmsMessageType", do: assert 140 == octet XMmsMessageType
  end

  test "decode" do
    assert decode(bytes()) === result()
  end

  test "encode" do
    assert encode(result()) === bytes()
  end
end
