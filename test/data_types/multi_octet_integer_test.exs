defmodule MMS.MultiOctetIntegerTest do
  use MMS.CodecTest
  import MMS.MultiOctetInteger

  codec_examples [
    {"0",      {<< 0 >>, <<>>},                     0},
    {"255",    {<< 255 >>, <<>>},                   255},
    {"256",    {<< 1, 0 >>, <<>>},                  256},
    {"65,535", {<< 255, 255 >>, <<>>},              65_535},
    {"max",    {<< max_long()::30*8>>, <<>>},       max_long()},
    {"> max",  {<< max_long()::30*8>>, <<"rest">>}, max_long()},
  ]

  decode_errors [
  ]

  encode_errors [
    {"negative", -1},
    {"too big",  max_long() + 1},
  ]
end
