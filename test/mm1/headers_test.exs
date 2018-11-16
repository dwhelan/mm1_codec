defmodule MM1.HeadersTest do
  use ExUnit.Case

  import MM1.Headers

  alias MM1.{Result, Headers, XMmsMessageType, Bcc}

  test "should return a Headers Result" do
    assert %Result{module: Headers} = decode <<>>
  end

  test "should decode Bcc" do
    assert %{value: [%{module: MM1.Bcc}]} = decode <<129, 0>>
  end

  test "should decode XMmsMessageType" do
    assert %{value: [%{module: MM1.XMmsMessageType}]} = decode <<140, 128>>
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
