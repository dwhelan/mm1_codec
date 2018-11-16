defmodule MM1.HeadersTest do
  use ExUnit.Case

  import MM1.Headers

  alias MM1.{Result, Headers, XMmsMessageType, Bcc}

  test "result should be a Headers Result" do
    assert %Result{module: Headers} = decode <<>>
  end

  test "value should be an array of Headers" do
    assert %{
             value: [
               %{module: XMmsMessageType, value: :m_send_req, bytes: <<140, 128>>},
               %{module: Bcc, value: 0, bytes: <<129, 0>>},
             ]
           } = decode <<140, 128, 129, 0>>
  end
end
