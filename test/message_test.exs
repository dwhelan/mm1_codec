defmodule MMS.MessageTest do
  use MMS.CodecTest
  import MMS.Message

  codec_examples [
    {"multiple headers", {<<s(12), s(0), s(23), "@\0">>, ""}, headers: [message_type: :m_send_req, to: "@"]},
  ]
end
