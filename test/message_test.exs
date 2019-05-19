defmodule MMS.MessageTest do
  use MMS.CodecTest
  import MMS.Message

  @message_type   <<s(12), s(0)>>
  @mms_version    <<s(13), 0b10000000>>
  @transaction_id <<s(24), "a\0">>

  codec_examples [
    {"multiple headers", {@message_type <> @transaction_id, ""}, headers: [message_type: :m_send_req, transaction_id: "a"]},
  ]
end
