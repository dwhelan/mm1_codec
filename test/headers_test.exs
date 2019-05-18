defmodule MMS.HeadersTest do
  use MMS.CodecTest
  import MMS.Headers

  codec_examples [
    {"multiple headers", {<<s(12), s(0), s(23), "@\0">>, ""}, message_type: :m_send_req, to: "@"},
  ]

  decode_errors [
    { "invalid header", <<0>>},
    { "first header is not message type", <<s(1), "@bcc\0">>},
  ]
end
