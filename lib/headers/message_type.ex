defmodule MMS.MessageType do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.16 X-Mms-Message-Type field

  Message-type-value = m-send-req | m-send-conf | m-notification-ind | m-notifyresp-ind | m-retrieve-conf | m-acknowledge-ind |
                       m-delivery-ind | m-read-rec-ind | m-read-orig-ind | m-forward-req | m-forward-conf

  m-send-req         = <Octet 128>
  m-send-conf        = <Octet 129>
  m-notification-ind = <Octet 130>
  m-notifyresp-ind   = <Octet 131>
  m-retrieve-conf    = <Octet 132>
  m-acknowledge-ind  = <Octet 133>
  m-delivery-ind     = <Octet 134>
  m-read-rec-ind     = <Octet 135>
  m-read-orig-ind    = <Octet 136>
  m-forward-req      = <Octet 137>
  m-forward-conf     = <Octet 138>
  """
  use MMS.Codec
  import Codec.Map
  alias MMS.Byte

  @map %{
    128 => :m_send_req,
    129 => :m_send_conf,
    130 => :m_notification_ind,
    131 => :m_notifyresp_ind,
    132 => :m_retrieve_conf,
    133 => :m_acknowledge_ind,
    134 => :m_delivery_ind,
    135 => :m_read_rec_ind,
    136 => :m_read_orig_ind,
    137 => :m_forward_ind,
    138 => :m_forward_conf,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(Byte, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode(Byte, @map)
  end
end
