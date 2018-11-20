defmodule MM1.HeadersTest do
  use ExUnit.Case
  import MM1.Headers

  use MM1.CodecTest

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

  describe "byte" do
    test "Bcc",             do: assert 129 == byte Bcc
    test "XMmsMessageType", do: assert 140 == byte XMmsMessageType
  end
end
