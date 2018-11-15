defmodule MM1Test do
  use ExUnit.Case

  import MM1.Message

  alias MM1.{Message, Headers, XMmsMessageType}

  describe "decode" do
    test "m_send_req" do
      actual = decode <<0x8c, 0x80>>
      assert %{
        module: Message,
        value: %{
          module: Headers,
          value: [
            %{module: XMmsMessageType, value: :m_send_req, bytes: <<0x8c, 0x80>>}
          ]
        }
      } = actual
    end
  end
end
