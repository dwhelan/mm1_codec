defmodule MMS.MessageTest do
  use MMS.CodecTest
  import MMS.Message

  @message_type <<s(12), s(0)>>
  @mms_version  <<s(13), 0b10000000>>

  codec_examples [
    {"multiple headers", {@message_type <> @mms_version, ""}, headers: [message_type: :m_send_req, version: {0, 0}]},
  ]
end
