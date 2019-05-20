defmodule MMS.UntypedParameterTest do
  use MMS.CodecTest
  import MMS.UntypedParameter

  codec_examples [
    {"text value",    <<"name\0", "value\0">>, {"name", "value"}},
    {"integer value", <<"name\0", s(0)>>,      {"name", 0      }},
  ]

  decode_errors [
    {"token text error",    <<"name", "value\0">>},
    {"untyped value error", <<"name\0", "value">>},
  ]

  encode_errors [
    {"token text error",    {:bad_name, "value"}},
    {"untyped value error", {"name", :bad_value}},
  ]
end
