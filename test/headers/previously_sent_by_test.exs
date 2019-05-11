defmodule MMS.PreviouslySentByTest do
  use MMS.CodecTest

  import MMS.PreviouslySentBy

  codec_examples [
    { "", << l(3), s(1), "@\0" >>, {{"@", ""}, 1  } }, # short count
  ]

  decode_errors [
    { "value length",  << 32 >>},
    { "integer value", << 2, 32 >>},
    { "address",       << l(4), l(2), 1, 0, "@" >>},
  ]

  encode_errors [
    { "", {"@", -1}, {:list, [-1, "@"]}},
  ]
end
