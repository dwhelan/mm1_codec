defmodule MM1Test do
  use ExUnit.Case

  import MM1.Message

  alias MM1.{Result, Message, Headers, XMmsMessageType, Bcc}

  test "should return a Result" do
    assert %Result{} = decode <<>>
  end

  test "result should be an MMS Message module" do
    assert %{module: Message} = decode <<>>
  end

  test "m_send_req" do
    actual = decode <<140, 128, 140, 129>>
    assert %{
      value: %{
        module: Headers,
        value: [
          %{module: XMmsMessageType, value: :m_send_req, bytes: <<140, 128>>},
          %{module: Bcc, value: 129, bytes: <<140, 129>>},
        ]
      }
    } = actual
  end
end
