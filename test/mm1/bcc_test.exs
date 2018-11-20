defmodule MM1.BccTest do
  alias MM1.{Result, Headers, Bcc}
  import Bcc
  use MM1.CodecTest

  def bytes do
    <<Headers.header_byte(Bcc), "abc", 0>>
  end

  def result do
    %Result{module: Bcc, value: "abc", bytes: bytes()}
  end

  describe "decode" do
    test "bytes" do
      assert decode(bytes()) === result()
    end
  end

  describe "encode" do
    test "result" do
      assert encode(result()) === bytes()
    end
  end
end
