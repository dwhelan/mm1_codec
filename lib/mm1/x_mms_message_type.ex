defmodule MM1.XMmsMessageType.Codec do
  alias MM1.Codecs.Mapper

  use Mapper,
      codec: WAP.ShortInteger,
      map: Mapper.ordinal_map [
        :m_send_conf,
        :m_notification_ind,
        :m_notifyresp_ind,
        :m_send_req,
        :m_retrieve_conf,
        :m_acknowledge_ind,
        :m_delivery_ind,
        :m_read_rec_ind,
        :m_read_orig_ind,
        :m_forward_ind,
        :m_forward_conf,
      ]

  def codec do
    WAP.ShortInteger
  end
end

defmodule MM1.XMmsMessageType do
  use MM1.Header, codec: MM1.XMmsMessageType.Codec

  alias MM1.Codecs.Mapper
  import Mapper

  @map Mapper.ordinal_map [
    :m_send_conf,
    :m_notification_ind,
    :m_notifyresp_ind,
    :m_send_req,
    :m_retrieve_conf,
    :m_acknowledge_ind,
    :m_delivery_ind,
    :m_read_rec_ind,
    :m_read_orig_ind,
    :m_forward_ind,
    :m_forward_conf,
  ]
  @unmap Mapper.invert(@map)

  def header_byte do
    140
  end

#  def decode <<140, bytes::binary>> do
#    decode bytes, WAP.ShortInteger, __MODULE__, @map
#  end
#
#  def encode result do
#    encode result, WAP.ShortInteger, __MODULE__
#  end
#
#  def new value do
#    new value, WAP.ShortInteger, __MODULE__, @map, @unmap
#  end
end
