defmodule MMS.HeadersTest do
  use MMS.CodecTest
  import MMS.Headers

  codec_examples [
    {"multiple headers", {<<s(1), "@bcc\0", s(2), "@cc\0">>, ""}, bcc: {"@bcc", ""}, cc: {"@cc", ""}},
  ]

  encode_errors [
    { "invalid header", <<0>>},
  ]
end
