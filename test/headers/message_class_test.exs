defmodule MMS.XMmsMessageClassTest do
  use MMS.CodecTest
  import MMS.XMmsMessageClass

  codec_examples [
    {"personal",      <<128>>,       :personal},
    {"advertisement", <<129>>,       :advertisement},
    {"informational", <<130>>,       :informational},
    {"auto",          <<131>>,       :auto},
    {"other",         <<"other\0">>, "other"},
  ]

  decode_errors [
    {"too small", <<127>>},
    {"too big",   <<132>>},
  ]
end

