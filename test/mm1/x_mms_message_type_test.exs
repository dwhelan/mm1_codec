defmodule MM1.XMmsMessageTypeTest do
  use ExUnit.Case

  alias MM1.{Result, Headers, XMmsMessageType}
  import XMmsMessageType

  message_types = [
    m_send_conf:        128,
    m_notification_ind: 129,
    m_notifyresp_ind:   130,
    m_send_req:         131,
    m_retrieve_conf:    132,
    m_acknowledge_ind:  133,
    m_delivery_ind:     134,
    m_read_rec_ind:     135,
    m_read_orig_ind:    136,
    m_forward_ind:      137,
    m_forward_conf:     138,
  ]

  def bytes do
    <<Headers.octet(XMmsMessageType), 128>>
  end

  def bytes(message_type) do
    <<Headers.octet(XMmsMessageType), message_type>>
  end

  def result do
    %Result{module: XMmsMessageType, value: :m_send_conf, bytes: bytes()}
  end

  describe "decode" do
    test "bytes" do
      assert decode(bytes() <> <<"rest">>) == %Result{result() | rest: <<"rest">>}
    end

    for message_type <- message_types do
      @value elem(message_type, 0)
      @octet elem(message_type, 1)

      test @value do
        assert decode(bytes(@octet)).value === @value
      end
    end
  end

  describe "encode" do
    test "result" do
      assert encode(result()) == bytes()
    end
  end
end
