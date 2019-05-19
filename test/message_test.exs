defmodule MMS.MessageTest do
  use MMS.CodecTest
  import MMS.Message

  @content_type   <<s(4),  s(0)>>
  @message_type   <<s(12), s(0)>>
  @mms_version    <<s(13), 0b10000000>>
  @transaction_id <<s(24), "a\0">>

  codec_examples [
    {
      "multiple headers",
      {@message_type <> @transaction_id  <> @mms_version <> @content_type, ""},
      headers: [message_type: :m_send_req, transaction_id: "a", version: {0,0}, content_type: 0]
    },
  ]
end
