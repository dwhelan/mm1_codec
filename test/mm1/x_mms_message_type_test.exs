defmodule MM1.BccTest do
  use ExUnit.Case

  alias MM1.{Result, Headers, Bcc}
  import Bcc

  def bytes do
    <<Headers.octet Bcc>> <> <<0>>
  end

  def result do
    %Result{module: Bcc, value: 0, bytes: bytes()}
  end

  describe "decode" do
    test "should decode" do
      assert decode(bytes() <> <<"rest">>) == %Result{result() | rest: <<"rest">>}
    end
  end

  describe "encode" do
    test "result" do
      assert encode(result()) == bytes()
    end
  end
end
