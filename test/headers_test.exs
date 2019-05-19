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
      {@message_type <> @mms_version, ""},
      message_type: :m_send_req, version: {0, 0}
    }, {
      "with required and optional headers in correct position",
      {@message_type <> @transaction_id <> @mms_version <> @content_type, ""},
      message_type: :m_send_req, transaction_id: "a", version: {0, 0}, content_type: 0
    },
  ]

  decode_errors [
    {"invalid header",            <<0>>},
    {"missing message type",      @mms_version},
    {"missing version",           @message_type},
    {"transaction_id not second", @message_type <> @mms_version <> @transaction_id},
    {"content_type not last",     @message_type <> @mms_version <> @content_type <> @to},
  ]

  encode_errors [
    {
      "invalid header",
      [message_type: :m_send_req, version: {0, 0}, invalid: :header],
      header: :out_of_range
    }, {
      "missing message type",
      [version: {0,0}],
      headers: :message_type_must_be_first_header
    }, {
      "missing version",
      [message_type: :m_send_req],
      headers: :version_must_be_second_header_when_no_transaction_id
    }, {
      "transaction_id not_second",
      [message_type: :m_send_req, version: {0, 0}, transaction_id: "a"],
      headers: :transaction_id_must_be_second_header_if_present
    }, {
      "content_type not last",
      [message_type: :m_send_req, version: {0, 0}, content_type: 0, to: "a"],
      headers: :content_type_must_be_the_last_header
    },
  ]
end
