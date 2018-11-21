defmodule MM1.HeadersTest do
  alias MM1.{Result, Headers, Bcc, BccTest}
  import Headers

  use MM1.CodecTest

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

  describe "header_byte/1" do
    test "Bcc",             do: assert 129 == header_byte Bcc
    test "XMmsMessageType", do: assert 140 == header_byte XMmsMessageType
  end
end
