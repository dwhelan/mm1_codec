defmodule MMS.HeadersTest do
  use MMS.CodecTest
  import MMS.Headers

  @content_type   <<s(4),  s(0)>>
  @message_type   <<s(12), s(0)>>
  @mms_version    <<s(13), 0b10000000>>
  @to             <<s(23), "a\0">>
  @transaction_id <<s(24), "a\0">>

  codec_examples [
    {
      "with required headers",
      {@message_type <> @mms_version <> @content_type, ""},
      message_type: :m_send_req, version: {0, 0}, content_type: 0
    }, {
      "with required and optional headers",
      {@message_type <> @transaction_id <> @mms_version <> @content_type, ""},
      message_type: :m_send_req, transaction_id: "a", version: {0, 0}, content_type: 0
    },
  ]

  decode_errors [
    {"invalid header",         <<0>>},
    {"missing message type",   @mms_version <> @content_type},
    {"missing version",        @message_type <> @content_type},
#    {"missing content type",   @message_type <> @mms_version},
  ]

  encode_errors [
    {"invalid header", [invalid: :header], header: :out_of_range}
  ]
end
