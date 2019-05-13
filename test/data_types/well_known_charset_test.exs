defmodule MMS.WellKnownCharsetTest do
  use MMS.CodecTest
  import MMS.WellKnownCharset

  codec_examples [
    {"Any-charset", << s(0) >>,           :AnyCharset},
    {"ASCII",       << s(3) >>,           :ASCII},
    {"UTF8",        << s(106) >>,         :UTF8},
    {"Unicode",     << l(2), 1000::16 >>, :Unicode},
  ]

  decode_errors [
    {"Reserved 1",  << s(1) >>},
    {"Reserved 2",  << s(2) >>},
    {"Not in list", << s(120) >>},
  ]

  encode_errors [
    {"Not in list", :unknown_charset},
  ]
end
