defmodule MMS.HeadersTest do
  use MMS.CodecTest
  import MMS.Headers

  @message_type <<s(12), s(0)>>
  @mms_version  <<s(13), 0b10000000>>
  @to           <<s(23), "a\0">>

  codec_examples [
    {"multiple headers", {@message_type <> @mms_version, ""}, message_type: :m_send_req, version: {0, 0}},
  ]

  decode_errors [
    { "invalid header", <<0>>},
    { "first header is not message type",  @to},
    { "second header is not mms version ", @message_type <> @to},
  ]
end
