defmodule MMS.HeadersTest do
  use MMS.CodecTest
  import MMS.Headers

  @message_type   <<s(12), s(0)>>
  @transaction_id <<s(24), "a\0">>
  @mms_version    <<s(13), 0b10000000>>
  @to             <<s(23), "a\0">>

  codec_examples [
    {"multiple headers", {@message_type <> @transaction_id, ""}, message_type: :m_send_req, transaction_id: "a"},
  ]

  decode_errors [
    {"invalid header", <<0>>},
    {"message type is not first header",    @to},
    {"transaction_id is not second header", @message_type <> @to},
  ]
end
