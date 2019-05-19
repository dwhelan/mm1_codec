defmodule MMS.HeadersTest do
  use MMS.CodecTest
  import MMS.Headers

  @message_type   <<s(12), s(0)>>
  @transaction_id <<s(24), "a\0">>
  @mms_version    <<s(13), 0b10000000>>
  @to             <<s(23), "a\0">>

  codec_examples [
    {"with required headers",  {@message_type <> @transaction_id <> @mms_version, ""}, message_type: :m_send_req, transaction_id: "a", version: {0, 0}},
    {"without transaction id", {@message_type <> @mms_version, ""},                    message_type: :m_send_req, version:   {0, 0}},
  ]

  decode_errors [
    {"invalid header", <<0>>},
    {"missing message type",   @transaction_id},
    {"missing transaction id", @message_type <> @to},
    {"missing version",        @message_type <> @transaction_id <> @to},
  ]

  encode_errors [
    {"invalid header", [invalid: :header], header: :out_of_range}
  ]
end
